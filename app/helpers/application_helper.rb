module ApplicationHelper
  def icon(name, **kwargs)
    kwargs.update(class: "bi bi-#{name}") { |_, v1, v2| token_list(v1, v2) }
    tag.i(**kwargs)
  end

  def tagifize(ary)
    ary.map { {value: _1 } }.to_json
  end
end
