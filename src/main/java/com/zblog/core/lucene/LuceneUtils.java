package com.zblog.core.lucene;

import org.apache.lucene.analysis.TokenStream;
import org.apache.lucene.document.FieldType;
import org.apache.lucene.index.IndexOptions;

import java.io.IOException;

public class LuceneUtils{

  private LuceneUtils(){
  }

  public static FieldType directType(){
    FieldType directType = new FieldType();
//    directType.setIndexed(true);
    directType.setIndexOptions(IndexOptions.DOCS);
    directType.setStored(true);

    return directType;
  }

  public static FieldType searchType(){
    FieldType searchType = new FieldType();
//    searchType.setIndexed(true);
    searchType.setIndexOptions(IndexOptions.DOCS);
    searchType.setStored(true);
    /* 设置分词 */
    searchType.setTokenized(true);

    return searchType;
  }

  public static FieldType storeType(){
    FieldType storeType = new FieldType();
    storeType.setStored(true);
//    storeType.setIndexed(false);

    return storeType;
  }

  public static void closeQuietly(TokenStream stream){
    if(stream == null)
      return;

    try{
      stream.close();
    }catch(IOException e){
      e.printStackTrace();
    }
  }

}
