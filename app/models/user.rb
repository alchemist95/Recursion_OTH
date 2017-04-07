class User < ApplicationRecord

	enum role: [
			:normal,
			:admin
						 ]

	def self.sign_in_from_omniauth(auth)
    find_by(provider: auth['provider'], uid: auth['uid']) ||
            create_user_from_omniauth(auth)
  end

  def self.create_user_from_omniauth(auth)
		uid=auth.uid
		info=auth.info.symbolize_keys!
		user=User.create(uid: uid)
		user.name=info.name+" "
		user.provider=auth.provider
		user.image_url=info.image
		user.score = 0
		user.email = info.email
		user.role = 0
		user.save!
		user
	end


end
