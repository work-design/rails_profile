json.extract! profile, :id, :real_name, :nick_name, :age, :birthday_type, :birthday, :address, :extra, :avatar_url
json.account profile.account, :id, :identity, :qrcode_url
