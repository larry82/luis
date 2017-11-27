module Luis
  # Luis entity class
  class Entity < Base
    attr_accessor :entity, :type, :start_index, :end_index, :score, :value

    def resolution
      if @resolution.present?
        begin
          @resolution["values"][0]
        rescue
          nil
        end
      else
        nil
      end
    end

    def chinese_value
      value = resolution || entity
      value.gsub(' ','')
    end

  end
end
