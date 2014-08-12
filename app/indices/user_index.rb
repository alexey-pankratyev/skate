ThinkingSphinx::Index.define :user, with: :active_record do
  
  # fields
  indexes name, sortable: true
  indexes email
  indexes nickname
  set_property enable_star: 1
  set_property min_infix_len: 3
  
  # attributes
  has  created_at, updated_at
end