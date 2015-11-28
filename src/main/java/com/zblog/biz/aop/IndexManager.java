package com.zblog.biz.aop;

import com.zblog.core.WebConstants;
import com.zblog.core.dal.constants.PostConstants;
import com.zblog.core.dal.entity.Post;
import com.zblog.core.lucene.LuceneUtils;
import com.zblog.core.lucene.QueryBuilder;
import com.zblog.core.lucene.SearchEnginer;
import com.zblog.core.plugin.MapContainer;
import com.zblog.core.plugin.PageModel;
import com.zblog.core.util.JsoupUtils;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.index.Term;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

/**
 * 文章Lucene索引管理器
 * 
 * @author zhou
 * 
 */
@Component
public class IndexManager{
  private static final Logger logger = LoggerFactory.getLogger(IndexManager.class);

  /**
   * 只有添加文章才插入Lucene索引
   * 
   * @param post
   */
  public void insert(Post post){
    if(PostConstants.TYPE_POST.equals(post.getType())){
      logger.debug("add post index -->" + post.getTitle());
      SearchEnginer.postEnginer().insert(convert(post));
    }
  }

  /**
   * 只有更新文章才更新Lucene索引
   * 
   * @param post
   * @param affect
   */
  public void update(Post post, boolean affect){
    if(PostConstants.TYPE_POST.equals(post.getType()) && affect){
      SearchEnginer.postEnginer().update(new Term("id", post.getId()), convert(post));
    }
  }

  public void remove(String postid, String postType){
    if(PostConstants.TYPE_POST.equals(postType))
      SearchEnginer.postEnginer().delete(new Term("id", postid));
  }

  public PageModel<MapContainer> search(String word, int pageIndex){
    PageModel<MapContainer> result = new PageModel<>(pageIndex, 15);
    QueryBuilder builder = new QueryBuilder(SearchEnginer.postEnginer().getAnalyzer());
    builder.addShould("title", word).addShould("excerpt", word);
    builder.addLighter("title", "excerpt");
    SearchEnginer.postEnginer().searchHighlight(builder, result);

    return result;
  }

  private static Document convert(Post post){
    Document doc = new Document();
    doc.add(new Field("id", post.getId() + "", LuceneUtils.directType()));
    doc.add(new Field("title", post.getTitle(), LuceneUtils.searchType()));
    /* 用jsoup剔除html标签 */
    doc.add(new Field("excerpt", JsoupUtils.plainText(post.getContent()), LuceneUtils.searchType()));
    // doc.add(new LongField("createTime", post.getCreateTime().getTime(),
    // LuceneUtils.storeType()));
    return doc;
  }

  public static void main(String[] args){
    WebConstants.APPLICATION_PATH = "/Users/hawky/workspace/project/analysis-ik/elasticsearch-analysis-ik/config/";
    String text = "IK Analyzer是一个结合词典分词和文法分词的中文分词开源工具包。它使用了全新的正向迭代最细粒度切分算法。";
    String title = "标题测试";
    Post post = new Post();
    post.setTitle(title);
    post.setContent(text);
    post.setId("1000");

    SearchEnginer.postEnginer().insert(convert(post));

    String keyword = "中文分词工具包";

    PageModel<MapContainer> result = new PageModel<>(1, 15);
    QueryBuilder builder = new QueryBuilder(SearchEnginer.postEnginer().getAnalyzer());
    builder.addShould("title", keyword).addShould("excerpt", keyword);
    builder.addLighter("title", "excerpt");
    SearchEnginer.postEnginer().searchHighlight(builder, result);
    System.out.println("re = "+result);
  }

}
