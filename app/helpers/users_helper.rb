module UsersHelper

  def get_type_string(t)
    return TYPE_VALUES[t]
  end
  
  def gravatar_for(user, options = { :size => 50 })
    gravatar_image_tag(user.email.downcase, :alt => h(user.name),
                                            :class => 'gravatar',
                                            :gravatar => options)
  end
  
  def edit_return_path
    if current_user_is_admin?
      users_path
    else
      root_path
    end
  end
  
end
