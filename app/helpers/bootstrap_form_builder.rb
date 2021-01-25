class BootstrapFormBuilder < ActionView::Helpers::FormBuilder
  delegate :safe_join, :tag, :t, to: :@template

  def text_field(*args, **kwargs)
    bootstrap_label_and_wrap(args.first, **kwargs) do
      super(*args, **merge_class('form-control', **kwargs))
    end
  end

  def text_area(*args, **kwargs)
    bootstrap_label_and_wrap(args.first, **kwargs) do
      super(*args, **merge_class('form-control', **kwargs))
    end
  end

  def parent_select(text_method: :full_name, **kwargs)
    collection_select(:parent_id, object.class.not_descendants_of(object), :id, text_method, {}, **kwargs)
  end

  def file_field(*args, **kwargs)
    bootstrap_label_and_wrap(args.first, **kwargs) do
      super(*args, **merge_class('form-control', **kwargs))
    end
  end

  def collection_select(*args, **kwargs)
    bootstrap_label_and_wrap(args.first, **kwargs) do
      super(*args, **merge_class('form-select', **kwargs))
    end
  end

  def submit(*args, **kwargs)
    super(*args, **merge_class('btn btn-primary', **kwargs))
  end

  private

  def bootstrap_label_and_wrap(name, label: nil, hint: nil, **)
    hint ||= t(".#{name}_hint_html", default: t(".#{name}_hint", default: ''))
    tag.div class: 'mb-3' do
      safe_join([
                  label(name, label, class: 'form-label'),
                  yield,
                  hint.presence.then { tag.span hint, class: 'form-text' }
                ])
    end
  end

  def merge_class(additional_class, **kwargs)
    kwargs.merge(class: additional_class) { |_, v1, v2| @template.token_list(v1, v2) }
  end
end
