module SlackGamebot
  module Commands
    class Challenge < SlackRubyBot::Commands::Base
      def self.call(client, data, match)
        challenger = ::User.find_create_or_update_by_slack_id!(client, data.user)
        arguments = match['expression'].split.reject(&:blank?) if match.names.include?('expression')
        arguments ||= []
        challenge = ::Challenge.create_from_teammates_and_opponents!(client.team, data.channel, challenger, arguments)
        send_message_with_gif client, data.channel, "#{challenge.challengers.map(&:user_name).and} challenged #{challenge.challenged.map(&:user_name).and} to a match!", 'challenge'
        logger.info "CHALLENGE: #{client.team.name} - #{challenge}"
      end
    end
  end
end
