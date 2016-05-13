package com.cs.base.strategy.inmemory;

import io.searchbox.action.Action;
import io.searchbox.client.JestClient;
import io.searchbox.client.JestClientFactory;
import io.searchbox.client.JestResult;
import io.searchbox.client.config.HttpClientConfig;
import io.searchbox.core.Bulk;
import io.searchbox.core.Delete;
import io.searchbox.core.DocumentResult;
import io.searchbox.core.Get;
import io.searchbox.core.Index;
import io.searchbox.core.Search;
import io.searchbox.core.SearchResult;
import io.searchbox.indices.CreateIndex;
import io.searchbox.indices.IndicesExists;
import io.searchbox.indices.mapping.PutMapping;
import io.searchbox.params.SearchType;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.elasticsearch.index.query.QueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.builder.SearchSourceBuilder;

import com.cs.base.interactor.entity.IEntity;
import com.cs.config.interactor.entity.IKlass;
import com.cs.config.interactor.entity.ITag;
import com.cs.config.interactor.entity.ITreeEntity;
import com.cs.config.interactor.entity.Tag;
import com.cs.config.interactor.entity.concrete.klass.ITask;
import com.cs.config.interactor.entity.concrete.klass.ProjectKlass;
import com.cs.config.interactor.entity.concrete.klass.Task;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

@SuppressWarnings("unchecked")
public class ElasticCacheImpl<T> implements ICache<T> {
  
  private static final String                 WEB_PROTOCOL           = "http://";
                                                                     
  private static final String                 SECURED_WEB_PROTOCOL   = "https://";
                                                                     
  private static final String                 elasticSearchPort      = "9200";
                                                                     
  private static final String                 elasticSearchHostName  = "192.168.132.96";
                                                                     
  private static final String                 elasticSearchIndexName = "allianz";
                                                                     
  private static final int                    MAX_RESULT_SIZE        = 10000;
                                                                     
  private static JestClient                   client;
                                              
  private final Class<T>                      className;
                                              
  private String                              docType;
                                              
  public static LinkedHashMap<String, ITag>   tags                   = new LinkedHashMap<String, ITag>();
                                                                     
  public static LinkedHashMap<String, IKlass> klasses                = new LinkedHashMap<String, IKlass>();
  
  public static LinkedHashMap<String, ITask> tasks                = new LinkedHashMap<String, ITask>();
                                                                     
  static {
    try {
      String connectionUrl = WEB_PROTOCOL + elasticSearchHostName + ":" + elasticSearchPort;
      JestClientFactory factory = new JestClientFactory();
      factory.setHttpClientConfig(new HttpClientConfig.Builder(connectionUrl).readTimeout(60000)
          .multiThreaded(true).build());
      client = factory.getObject();
      
      Action action = new IndicesExists.Builder(elasticSearchIndexName).build();
      JestResult result = client.execute(action);
      
      if (!result.isSucceeded()) {
        CreateIndex createIndex = new CreateIndex.Builder(elasticSearchIndexName).build();
        client.execute(createIndex);
      }
      
      InputStream stream = ElasticCacheImpl.class.getClassLoader().getResourceAsStream("taskInstanceMapping.json");
      ObjectMapper mapper = new ObjectMapper();
      Map<String, Object> mapping = mapper.readValue(stream, Map.class);
      String mappingJson = mapper.writeValueAsString(mapping);
      PutMapping putMapping = new PutMapping.Builder(elasticSearchIndexName, ICache.TASKINSTANCE_CACHE, mappingJson)
              .build();
      client.execute(putMapping);

      stream = ElasticCacheImpl.class.getClassLoader().getResourceAsStream("taskInstanceVersionMapping.json");
      mapper = new ObjectMapper();
      mapping = mapper.readValue(stream, Map.class);
      mappingJson = mapper.writeValueAsString(mapping);
      putMapping = new PutMapping.Builder(elasticSearchIndexName, ICache.TASKINSTANCEVERSION_CACHE, mappingJson).build();
      client.execute(putMapping);

      ElasticCacheImpl.fillHashMapForTreeEntities();
    }
    catch (Exception e) {
      throw new RuntimeException(e);
    }
  }
  
  public ElasticCacheImpl(String cacheName, Class<T> className)
  {
    this.className = className;
    this.docType = cacheName;
    if (cacheName.equalsIgnoreCase("configuration"))
      return;
    if (className == null)
      throw new RuntimeException("Expected a className parameter but found NULL");
  }
  
  @Override
  public T get(String key)
  {
    T resultObj = null;
    if (getDocType().equals(ICache.TASK_CACHE)) {
      resultObj = (T) ElasticCacheImpl.tasks.get(key);
      
    }
    else if (getDocType().equals(ICache.KLASS_CACHE)) {
      resultObj = (T) ElasticCacheImpl.klasses.get(key);
      
    }
    else if (getDocType().equals(ICache.TAG_CACHE)) {
      resultObj = (T) ElasticCacheImpl.tags.get(key);
      
    }
    else {
      Get get = new Get.Builder(elasticSearchIndexName, key).type(getDocType()).build();
      try {
        JestResult result = client.execute(get);
        if (result.isSucceeded()) {
          JsonObject resultJson = result.getJsonObject();
          String source = resultJson.get("_source").toString();
          resultObj = new ObjectMapper().readValue(source, className);
        }
      }
      catch (IOException e) {
        throw new RuntimeException(e);
      }
    }
    
    return resultObj;
  }
  
  @Override
  public boolean remove(String key)
  {
    if (ITreeEntity.class.isAssignableFrom(this.className)) {
      if (ITag.class.isAssignableFrom(this.className)) {
        ElasticCacheImpl.tags.remove(key);
        
      }
      else if (ITask.class.isAssignableFrom(this.className)) {
        ElasticCacheImpl.tasks.remove(key);
      }
      else if (IKlass.class.isAssignableFrom(this.className)) {
        ElasticCacheImpl.klasses.remove(key);
      }

    }
    
    Delete clientRequest = new Delete.Builder(key).index(elasticSearchIndexName).type(getDocType())
        .build();
        
    try {
      client.execute(clientRequest);
    }
    catch (IOException e) {
      throw new RuntimeException(e);
    }
    
    return true;
  }
  
  @Override
  public boolean remove(List<String> ids)
  {
    
    Bulk.Builder bulkBuilder = new Bulk.Builder();
    for (String id : ids) {
      bulkBuilder.addAction(new Delete.Builder(id).index(elasticSearchIndexName).type(getDocType()).build());
    }
    
    Bulk bulkDeleteRequest = bulkBuilder.build();
    client.executeAsync(bulkDeleteRequest, null);
    
    return true;
  }
  
  @Override
  public Collection<T> values()
  {
    return values(0, MAX_RESULT_SIZE);
  }
  
  @Override
  public Collection<T> values(Integer from, Integer size)
  {
    Collection<T> data = new ArrayList<>();
    
    if (ITreeEntity.class.isAssignableFrom(this.className)) {
      if (ITag.class.isAssignableFrom(this.className)) {
        data.addAll((Collection<T>) ElasticCacheImpl.tags.values());
        
      }
      else if (ITask.class.isAssignableFrom(this.className)) {
        data.addAll((Collection<T>) ElasticCacheImpl.tasks.values());
      }
      else if (IKlass.class.isAssignableFrom(this.className)) {
        data.addAll((Collection<T>) ElasticCacheImpl.klasses.values());
      }
      
    }
    else {
      SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder().from(from).size(size);
      
      Search search = new Search.Builder(searchSourceBuilder.toString())
          .addIndex(elasticSearchIndexName).addType(getDocType()).build();
      data = extractList(search);
    }
    
    return data;
  }
  
  @Override
  public void put(String key, T data)
  {
    T topLevelParent = null;
    if (data instanceof ITreeEntity) {
      if (getDocType().equals(ICache.TASK_CACHE)) {
        ElasticCacheImpl.tasks.put(key, (ITask) data);
        topLevelParent = getTopLevelParentRecursively(data);
      }
      else if (getDocType().equals(ICache.KLASS_CACHE)) {
        ElasticCacheImpl.klasses.put(key, (IKlass) data);
        topLevelParent = getTopLevelParentKlassRecursively(data);
        
      }
      else if (getDocType().equals(ICache.TAG_CACHE)) {
        ElasticCacheImpl.tags.put(key, (ITag) data);
        topLevelParent = getTopLevelParentTagRecursively(data);
      }

      key = topLevelParent != null ? ((IEntity) topLevelParent).getId() : key;
    }
    
    ObjectMapper mapper = new ObjectMapper();
    Map<String, Object> dataAsMap = mapper
        .convertValue(topLevelParent != null ? topLevelParent : data, Map.class);
        
    Index clientRequest = new Index.Builder(dataAsMap).index(elasticSearchIndexName)
        .type(getDocType()).id(key).build();
        
    try {
      client.execute(clientRequest);
    }
    catch (IOException e) {
      throw new RuntimeException(e);
    }
  }
  
  @Override
  public Collection<T> find(String key, Object value)
  {
    Collection<T> data = new ArrayList<>();
    QueryBuilder query;
    if (key.contains(".")) {
      int index = key.lastIndexOf(".");
      String path = key.substring(0, index);
      query = QueryBuilders.nestedQuery(path, QueryBuilders.termsQuery(key, value));
    
    } else {
      query = QueryBuilders.termQuery(key, value);
    }

    SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder()
        .query(query)
        .size(MAX_RESULT_SIZE);
    
    Search search = (Search) new Search.Builder(searchSourceBuilder.toString())
        .addIndex(elasticSearchIndexName)
        .addType(getDocType())
        .setSearchType(SearchType.QUERY_THEN_FETCH)
        .build();
    
    data = extractList(search);
    
    return data;
  }
  
  @Override
  public Collection<T> find(String key, Object value, String... fieldsToFetch)
  {
    Collection<T> data = new ArrayList<>();
    QueryBuilder query;
    if (key.contains(".")) {
      int index = key.lastIndexOf(".");
      String path = key.substring(0, index);
      query = QueryBuilders.nestedQuery(path, QueryBuilders.termsQuery(key, value));
    
    } else {
      query = QueryBuilders.termQuery(key, value);
    }

    SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder()
        .query(query)
        .fetchSource(fieldsToFetch, new String[] {})
        .size(MAX_RESULT_SIZE);
    
    Search search = (Search) new Search.Builder(searchSourceBuilder.toString())
        .addIndex(elasticSearchIndexName)
        .addType(getDocType())
        .setSearchType(SearchType.QUERY_THEN_FETCH)
        .build();
    
    data = extractList(search);
    
    return data;
  }
  
  @Override
  public void shutdown()
  {
    client.shutdownClient();
  }
  
  @Override
  public String getCachePath()
  {
    return "Check ElasticSearch Server directory";
  }
  
  public String getDocType()
  {
    return this.docType;
  }
  
  public static void fillHashMapForTreeEntities()
  {
    try {
      // get all tags from elasticsearch and fill in HashMap
      SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder().from(0).size(10000);
      
      Search search = new Search.Builder(searchSourceBuilder.toString())
          .addIndex(elasticSearchIndexName).addType(ICache.TAG_CACHE).build();
      SearchResult result = client.execute(search);
      if (result.isSucceeded()) {
        putObjectsInHashMap(result, ICache.TAG_CACHE);
      }
      
      // get all klasses from elasticsearch and fill in HashMap
      search = new Search.Builder(searchSourceBuilder.toString()).addIndex(elasticSearchIndexName)
          .addType(ICache.KLASS_CACHE).build();
      result = client.execute(search);
      if (result.isSucceeded()) {
        putObjectsInHashMap(result, ICache.KLASS_CACHE);
      }
      
      // get all tasks from elasticsearch and fill in HashMap
      search = new Search.Builder(searchSourceBuilder.toString()).addIndex(elasticSearchIndexName)
          .addType(ICache.TASK_CACHE).build();
      result = client.execute(search);
      if (result.isSucceeded()) {
        putObjectsInHashMap(result, ICache.TASK_CACHE);
      }
    }
    catch (IOException e) {
      throw new RuntimeException(e);
    }
  }
  
  private static void putObjectsInHashMap(SearchResult result, String docType)
      throws IOException, JsonParseException, JsonMappingException
  {
    JsonObject resultJson = result.getJsonObject();
    JsonObject jsonHits = resultJson.get("hits").getAsJsonObject();
    JsonArray JsonHitsArray = jsonHits.get("hits").getAsJsonArray();
    
    ObjectMapper mapper = new ObjectMapper();
    
    for (JsonElement jsonElement : JsonHitsArray) {
      JsonObject jsonObject = jsonElement.getAsJsonObject();
      String jsonString = jsonObject.get("_source").toString();
      
      deserializeEntityAndPushInMap(docType, jsonString, mapper);
    }
  }
  
  private static void deserializeEntityAndPushInMap(String docType, String json,
      ObjectMapper mapper) throws JsonParseException, JsonMappingException, IOException
  {
    ITreeEntity content = null;
    if (docType.equals(ICache.TAG_CACHE)) {
      content = mapper.readValue(json, Tag.class);
      pushTreeEntityInMapRecursively(content, docType);
      
    }
    else if (docType.equals(ICache.TASK_CACHE)) {
      content = mapper.readValue(json, Task.class);
      pushTreeEntityInMapRecursively(content, docType);
    }
    else if (docType.equals(ICache.KLASS_CACHE)) {
      content = mapper.readValue(json, ProjectKlass.class);
      pushTreeEntityInMapRecursively(content, docType);
    }

  }
  
  private static void pushTreeEntityInMapRecursively(ITreeEntity content, String docType)
  {
    List<ITreeEntity> children = (List<ITreeEntity>) content.getChildren();
    for (ITreeEntity childrenTag : children) {
      pushTreeEntityInMapRecursively(childrenTag, docType);
    }
    insertDataInMap(content, docType);
  }
  
  private static void insertDataInMap(ITreeEntity content, String docType)
  {
    if (docType.equals(ICache.TAG_CACHE)) {
      ElasticCacheImpl.tags.put(content.getId(), (Tag) content);
    }
    else if (docType.equals(ICache.TASK_CACHE)) {
      ElasticCacheImpl.tasks.put(content.getId(), (ITask) content);
    }
    else if (docType.equals(ICache.KLASS_CACHE)) {
      ElasticCacheImpl.klasses.put(content.getId(), (IKlass) content);
    }
  }
  
  private T getTopLevelParentKlassRecursively(T data)
  {
    IKlass klass = (IKlass) data;
    IKlass parentKlass = (IKlass) klass.getParent();
    if (parentKlass != null) {
      String parentId = parentKlass.getId();
      IKlass parent = ElasticCacheImpl.klasses.get(parentId);
      return getTopLevelParentKlassRecursively((T) parent);
    }
    
    return data;
  }
  
  private T getTopLevelParentTagRecursively(T data)
  {
    ITag klass = (ITag) data;
    ITag parentKlass = (ITag) klass.getParent();
    if (parentKlass != null) {
      String parentId = parentKlass.getId();
      ITag parent = ElasticCacheImpl.tags.get(parentId);
      return getTopLevelParentTagRecursively((T) parent);
    }
    
    return data;
  }
  
  private Collection<T> extractList(Search search)
  {
    try {
      Collection<T> data = new ArrayList<>();
      
      SearchResult result = client.execute(search);
      if (result.isSucceeded()) {
        // hits.addAll(result.getSourceAsObjectList(Content.class));
        JsonObject resultJson = result.getJsonObject();
        JsonObject jsonHits = resultJson.get("hits").getAsJsonObject();
        JsonArray JsonHitsArray = jsonHits.get("hits").getAsJsonArray();
        
        ObjectMapper objectMapper = new ObjectMapper();
        
        for (JsonElement jsonElement : JsonHitsArray) {
          JsonObject jsonObject = jsonElement.getAsJsonObject();
          String jsonString = jsonObject.get("_source").toString();
          T content = objectMapper.readValue(jsonString, className);
          data.add(content);
        }
      }
      
      return data;
    }
    catch (IOException e) {
      throw new RuntimeException(e);
    }
  }

  private T getTopLevelParentRecursively(T data)
  {
    ITreeEntity treeEntity = (ITreeEntity) data;
    ITreeEntity parent = (ITreeEntity) treeEntity.getParent();
    if (parent != null) {
      String parentId = parent.getId();
      ITreeEntity parentEntity = null;
      if (docType.equals(ICache.TASK_CACHE)) {        
         parentEntity = ElasticCacheImpl.tasks.get(parentId);
      }
      return getTopLevelParentRecursively((T) parentEntity);
    }
    
    return data;
  }

}

