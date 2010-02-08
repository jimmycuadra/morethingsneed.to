u = User.new(:password => APP_CONFIG['jimmy_default_password'], :password_confirmation => APP_CONFIG['jimmy_default_password'], :email => APP_CONFIG['jimmy_email'])
u.username = 'Jimmy'
u.admin = true
u.active = true
u.save

u = User.new(:password => APP_CONFIG['mike_default_password'], :password_confirmation => APP_CONFIG['mike_default_password'], :email => APP_CONFIG['mike_email'])
u.username = 'nebyoolae'
u.admin = true
u.active = true
u.save
