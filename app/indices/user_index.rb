ThinkingSphinx::Index.define :user, with: :active_record do
  
  # fields
  indexes name, sortable: true
  indexes email
  
  # attributes
  has  created_at, updated_at
end