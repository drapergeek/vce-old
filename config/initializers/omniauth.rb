Rails.application.config.middleware.use OmniAuth::Builder do  
  provider :twitter, 'YiA3y4YnMhEHpJHcmpLyA', 'Vd1gsygAjAMTOlZuTUC7GVuTTgv6ZpeqaKGYgAeYP0'  
  provider :facebook, '169538456423423', 'b415381001c7580330a8180a880d5459'
end

