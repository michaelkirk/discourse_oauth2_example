# name: existing_site_oauth2
# about: Authenticate with discourse via ExistingSite's Oauth
# version: 0.2.0
# authors: Michael Kirk

require 'auth/oauth2_authenticator'

class ExistingSiteAuthenticator < ::Auth::OAuth2Authenticator

  CLIENT_ID = 'ASDFASDF'
  CLIENT_SECRET = 'ASDF1234'

  def register_middleware(omniauth)
    omniauth.provider :existing_site_oauth,
      CLIENT_ID,
      CLIENT_SECRET
  end
end

require 'omniauth-oauth2'
class OmniAuth::Strategies::ExistingSiteOauth < OmniAuth::Strategies::OAuth2

  # NOTE VM has to be able to resolve
  SITE_URL = 'https://my-existing-site.com'

  # Give your strategy a name.
  option :name, "existing_site_oauth"

  # This is where you pass the options you would pass when
  # initializing your consumer from the OAuth gem.
  option :client_options, site: SITE_URL

  # These are called after authentication has succeeded. If
  # possible, you should try to set the UID without making
  # additional calls (if the user id is returned with the token
  # or as a URI parameter). This may not be possible with all
  # providers.
  uid{ raw_info['id'] }

  info do
    {
      :name => raw_info['name'],
      :email => raw_info['email']
    }
  end

  extra do
    {
      'raw_info' => raw_info
    }
  end

  def raw_info
    @raw_info ||= access_token.get('/api/v1/users/me.json').parsed
  end
end

auth_provider :title => 'Click here to sign in.',
    :message => 'Log in via the main site (Make sure pop up blockers are not enbaled).',
    :frame_width => 920,
    :frame_height => 800,
    :authenticator => ExistingSiteAuthenticator.new('existing_site_oauth', trusted: true)

register_css <<CSS

.btn-social.existing_site_oauth {
  background: #dd4814;
}

CSS
