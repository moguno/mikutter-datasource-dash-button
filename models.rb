class DashButtonUser < Retriever::Model
  include Retriever::Model::UserMixin

  register(:dashbutton_user, name: "Amazon Dash Button User")

  field.string(:idname, required: true)
  field.string(:name, required: true)
  field.string(:idname, required: true)
  field.string(:uri, required: true)
  field.string(:profile_image_url, required: true)
end

class DashButtonMessage < Retriever::Model
  include Retriever::Model::MessageMixin

  register(:dashbutton_message, name: "Amazon Dash Button Message")

  field.string(:description, required: true)
  field.time(:created, required: true)
  field.has(:user, DashButtonUser, required: true)
end


