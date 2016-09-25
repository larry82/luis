module Luis
  class Result < Base
    attr_accessor :query, :intents, :entities, :dialog, :top_scoring_indent

    def top_scoring_intent
      @topScoringIndent ||= @intents.first
    end

    def intents
      (@intents ||= [@topScoringIntent]).map do |intent|
        Intent.new intent
      end
    end

    def dialog
      Dialog.new @dialog
    end

    def awaiting_dialog_response?
      dialog && (dialog['status'] == 'Question')
    end
  end
end
