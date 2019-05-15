json.extract! user,
              :id,
              :name,
              :email,
              :mobile,
              :locale,
              :timezone,
              :avatar_url
json.oauth_users user.oauth_users, :id, :provider, :uid, :app_id
json.accounts user.accounts, :identity, :confirmed, :primary
json.profile user.profile, :real_name, :nick_name, :age, :birthday_type, :birthday, :address
