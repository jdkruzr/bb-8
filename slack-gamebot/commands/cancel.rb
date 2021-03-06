module SlackGamebot
  module Commands
    class Cancel < SlackRubyBot::Commands::Base
      def self.call(client, data, _match)
        player = ::User.find_create_or_update_by_slack_id!(client, data.user)
        challenge = ::Challenge.find_by_user(client.team, data.channel, player)
        if challenge
          challenge.cancel!(player)
          if challenge.challengers.include?(player)
            send_message_with_gif client, data.channel, "#{challenge.challengers.map(&:user_name).and} canceled a challenge against #{challenge.challenged.map(&:user_name).and}.", 'chicken'
          elsif challenge.challenged.include?(player)
            send_message_with_gif client, data.channel, "#{challenge.challenged.map(&:user_name).and} canceled a challenge against #{challenge.challengers.map(&:user_name).and}.", 'chicken'
          else
            send_message_with_gif client, data.channel, "#{player.user_name} canceled #{challenge}.", 'chicken'
          end
          logger.info "CANCEL: #{client.team.name} - #{challenge}"
        else
          send_message client, data.channel, 'No challenge to cancel!'
          logger.info "CANCEL:#{client.team.name} -  #{data.user}, N/A"
        end
      end
    end
  end
end
