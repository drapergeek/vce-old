

# == Schema Information
#
# Table name: users
#
#  id                        :integer         not null, primary key
#  login                     :string(255)
#  email                     :string(255)
#  crypted_password          :string(40)
#  salt                      :string(40)
#  created_at                :datetime
#  updated_at                :datetime
#  remember_token            :string(255)
#  remember_token_expires_at :datetime
#  lname                     :string(255)
#  fname                     :string(255)
#  content_type              :string(255)     default("image/png")
#  picture                   :binary
#  title                     :string(255)
#  unit_id                   :integer
#  provider                  :string(255)
#  uid                       :string(255)
#  authorized                :boolean         default(FALSE), not null
#

