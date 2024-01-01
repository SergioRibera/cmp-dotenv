local utils = {}

function utils.build_completions(instance, opts)
  for key, v in pairs(instance.env_variables) do
    local docs = ''
    if opts.show_content_on_docs then
      docs = 'Content: ' .. v.value
    end

    if v.docs ~= nil then
      docs = v.docs .. '\n\n' .. docs
    end

    table.insert(instance.completion_items, {
      label = key,
      insertText = opts.eval_on_confirm and v.value or key,
      word = key,
      documentation = opts.show_documentation and {
        kind = opts.documentation_kind,
        value = docs,
      },
      kind = opts.item_kind,
    })
  end
end

function utils.clear_table(t)
  for k in pairs(t) do
    t[k] = nil
  end
end

return utils
