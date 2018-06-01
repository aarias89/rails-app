# sets cookie for signed in user and makes it available to find_current_user method we created ,located in
# application_cable/connection

Warden::Manager.after_set_user do |user, auth, opts|
  scope = opts[:scope]
  auth.cookies.signed["#{scope}.id"] = user.id
end

#clears the cookie when user signs out

Warden::Manager.before_logout do |user, auth, opts|
  scope = opts[:scope]
  auth.cookies.signed["#{scope}.id"] = nil
end