module Luis
  # Luis entity class
  class Entity < Base
    attr_accessor :entity, :type, :start_index, :end_index, :score

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

  end
end
