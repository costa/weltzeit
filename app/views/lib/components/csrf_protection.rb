module CsrfProtection
  def self.included(mod)
    mod.param :authenticity_token, type: String
  end

  def protected_form(*args, **opts)
    FORM(*args, **opts) do
      INPUT(type: :hidden, name: :authenticity_token, value: params.authenticity_token)

      yield  if block_given?
    end
  end
end
