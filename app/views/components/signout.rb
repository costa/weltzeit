class Signout < React::Component::Base

  render do
    DIV.sign do
      A(href: '/users/sign_out', data: {method: :delete}) do
        "Sign Out"
      end
    end
  end
end
