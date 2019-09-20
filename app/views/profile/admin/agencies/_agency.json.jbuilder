json.extract! agency,
              :id,
              :relation,
              :relation_i18n
json.client agency.client, :id, :real_name
if agency.agent
  json.agent agency.agent, :id, :real_name
end
