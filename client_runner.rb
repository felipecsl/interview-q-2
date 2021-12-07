# frozen_string_literal: true

require 'httparty'
require 'digest'

module QuikNode
  module API
    class Base
      include HTTParty
      base_uri 'https://quiknode.pro'

      def details(id:, referrer_only: false, admin_token: nil)
        {
          'http_provider' => "https://qn-fullstack-proxy.herokuapp.com/#{admin_token}/"
        }
      end

      def last_block(ex_id:, token:)
        params = {
          jsonrpc: '2.0',
          method: 'eth_blockNumber',
          params: [],
          id: 1,
        }
        resp = self.class.post(
          details(id: ex_id, admin_token: token)['http_provider'], 
          body: params.to_json
        )
        resp.parsed_response['result'].to_i(16)
      rescue => e
        0
      end
    end
  end
end

module QuikNode
  module API
    class Eth < QuikNode::API::Base
    end
  end
end

puts QuikNode::API::Eth.new.last_block(ex_id: "any", token: "2f568e4df78544629ce9af64bbe3cef9145895f5")
