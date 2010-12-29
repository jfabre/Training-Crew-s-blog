require 'meta_weblog_structs'

class MetaWeblogService < XMLRPCService
   web_service_api MetaWeblogApi
   
   def initialize(logger = nil)
     @logger = logger
   end  
   def newMediaObject(blogid,username,password,data)
      authenticate(username,password)
       
      @image = Image.new({:name => File.basename(data.name)})
      @image.save_img(@image.name, data.bits)
      @image.save! 
      
      Url.new(:url=> @image.amazon_url)
   end

   def getRecentPosts(blogid, username, password, limit)
     authenticate(username,password)
     posts=Post.find(:all, :limit=>limit, :order=>"published_at DESC")
     articles=posts.collect { |c| struct_from(c) }
     articles
   end
   
   def getCategories(blogid,username,password)
     cats=Category.all
     cats.collect do |c|
       CategoryInfo.new(
          :categoryId=>c.id,
          :parentId=>'',
          :description=>c.title,
          :categoryName=>c.title,
          :title=>c.title,
          :htmlUrl=>"#{Blog.url}/category/#{c.title}",
          :rssUrl=>''
       )
     end
   end
   
   def editPost(id, username, password, hash, publish)
     authenticate(username,password)
     
     article=Article.new(hash)
     post = Post.find(id)
      
     bind_post(post, article)
     post.is_published = publish == 1
     post.save!
     
     assign_categories(article, post)
     
     true
   end
   def deletePost(postId, username, password, publish)
      authenticate(username, password)
      
      Post.delete(postId)
      true
   end
   def newPost(blogid, username,password,hash,publish)
      authenticate(username,password)
      
      article = Article.new(hash)
      post = Post.new
      
      bind_post(post,article)
      post.is_published = publish == 1
      post.save!
      assign_categories(article,post)

      post.id 
   end
   
   def assign_categories(article, post)
     post.clear_categories
     Category.clear_posts(post)
     
     unless article.categories.blank?
       article.categories.each do |cat|
         Category.categorize(cat,post)
       end
     end
   end
   
   def getPost(id, username, password)
     authenticate(username,password)
     
     struct_from(Post.find(id))
   end

   def bind_post(post,article)
     post.is_published = true
     
     post.title=article.title
     post.published_at = Time.now if post.published_at.nil?
     article.wp_slug = '' if article.wp_slug.nil?
     
     if(article.mt_text_more)
       #the post has been split so pop the description as the excerpt,
       #and the body as the mt_text_more
       post.excerpt=article.description
       post.body=article.mt_text_more
     else
       #just push the whole thing to the body
       post.body=article.description
       post.excerpt=""
     end

     #for posterity
     if(article.postid)
       post.post_id=article.postid.to_i
     end
    
     #reset the pub date if it was passed in
     if(article.date_created_gmt)
       dc = article.date_created_gmt
       pub_date = Time.gm(dc.year,dc.month,dc.day,0,0,0,0) #don't need time here
       post.published_at = pub_date
     end
     
     if(post.published_at > Time.now.to_date)
       post.is_published = false
     end
     
     #set the slug
     if(article.wp_slug != '')
       post.slug=article.wp_slug.downcase
     else
       post.slug = Post.create_slug(post.title)
     end

     post
   end
 
   def struct_from(post)
       Article.new(
       :description       => post.excerpt,
       :title             => post.title,
       :postid            => post.id.to_s,
       :url               => "#{Blog.url}#{post.url}",
       :link              => "#{Blog.url}#{post.url}",
       :permaLink         => "#{Blog.url}#{post.url}",
       :categories        => post.categories.collect{|c| c.title},
       :mt_text_more      => post.body,
       :mt_excerpt        => "",
       :mt_keywords       => "",
       :mt_allow_comments => 1,
       :mt_allow_pings    => 0,
       :mt_convert_breaks => "",
       :wp_slug           => post.slug,
       :dateCreated       => post.published_at,
       :date_created_gmt  => post.published_at,
       :pubDate           => post.published_at
      )
   end

end

