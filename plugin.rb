# name: oauth2_example
# about: Authenticate with discourse via Oauth2
# version: 0.1.0
# authors: Michael Kirk

require 'omniauth-oauth2'

oauth2_site = ENV['example_oauth_site_url']
client_id = ENV['example_oauth_client_id']
client_secret = ENV['example_oauth_client_secret']

auth_provider :oauth2,
    :name => 'example_oauth',
    :title => 'with example',
    :message => 'Log in via the main site (Make sure pop up blockers are not enbaled).',
    :frame_width => 920,
    :frame_height => 800,
    :client_id => client_id,
    :client_secret => client_secret,
    :client_options => {
      :site => oauth2_site,
    },
    :setup => lambda { |env|
      strategy = env["omniauth.strategy"]

      #FIXME This is pretty fucked.
      # But two things:
      #
      # 1. I don't know how to require 'foo' from within a plugin
      #
      # 2. When defining a class within this file I'm getting a WrongConstant
      # error
      #
      strategy.class.send(:include, OauthMixin)
    }

module OauthMixin
  def raw_info
    @raw_info ||= access_token.get('/api/v1/users/me.json').parsed
  end

  def self.included(base)

    base.uid { raw_info['id'] }
    base.info do
      {
        :name => raw_info['name'],
        :email => raw_info['email']
      }
    end

    base.extra do
      {
        'raw_info' => raw_info
      }
    end
  end
end


register_css <<CSS

.btn-social.example_oauth {
  background: #dd4814;
}

CSS
