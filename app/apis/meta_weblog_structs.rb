class CategoryInfo < ActionWebService::Struct
    member :categoryId,     :string
    member :parentId,       :string
    member :description,    :string
    member :categoryName,   :string
    member :title,          :string
    member :htmlUrl,        :string
    member :rssUrl,         :string
end

class ArticleComment< ActionWebService::Struct
    member :date_created_gmt, :date
    member :user_id,          :string
    member :comment_id,       :string
    member :comment_parent,   :string
    member :status,           :string
    member :content,          :string
    member :link,             :string
    member :post_id,          :string
    member :post_title,       :string
    member :author,           :string
    member :author_url,       :string
    member :author_email,     :string
    member :author_ip,        :string
    member :type,             :string
end

class Article < ActionWebService::Struct
  member :description,        :string
  member :title,              :string
  member :postid,             :string
  member :url,                :string
  member :link,               :string
  member :permaLink,          :string
  member :categories,         [:string]
  member :mt_text_more,       :string
  member :mt_basename,       :string
  member :mt_excerpt,         :string
  member :mt_keywords,        :string
  member :mt_allow_comments,  :int
  member :mt_allow_pings,     :int
  member :mt_convert_breaks,  :string
  member :dateCreated,        :time
  member :wp_slug,            :string
  member :pubDate,            :time
  member :date_created_gmt,    :time
end



class MediaObject < ActionWebService::Struct
    member :bits, :string
    member :name, :string
    member :type, :string
end

class Url < ActionWebService::Struct
    member :url, :string
end
class MetaWeblogApi < ActionWebService::API::Base
  inflect_names false

  api_method :getRecentPosts,
    :expects => [{:blogid=>:string}, {:username=>:string}, {:password=>:string}, {:numberOfPosts=>:string}],
    :returns => [[Article]]
  
  api_method :getPost,
    :expects => [ {:postid => :string}, {:username => :string}, {:password => :string} ],
    :returns => [Article]
  
  api_method :newPost,
    :expects => [ {:blogid => :string}, {:username => :string}, {:password => :string}, {:struct => Article}, {:publish => :int} ],
    :returns => [:string]
    
  api_method :editPost,
    :expects => [ {:postid => :string}, {:username => :string}, {:password => :string}, {:struct => Article}, {:publish => :int} ],
    :returns => [:bool]
  
  api_method :getCategories,
     :expects => [ {:blogid => :string}, {:username => :string}, {:password => :string} ],
     :returns => [[CategoryInfo]]
     
  api_method :newMediaObject,
     :expects => [ {:blogid => :string}, {:username => :string}, {:password => :string}, {:data => MediaObject} ],
     :returns => [Url]
     
  api_method :deletePost,
    :expects =>  [{:postid => :string}, {:username=>:string}, {:password=>:string}, {:publish => :int}],
    :returns => [:bool]
end