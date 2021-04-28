# We need to init this first or Rails gets upset
module ActiveRecord::Relation::QueryMethods

end

module ActiveRecord::QueryMethods
  class WhereIsArel
    attr_accessor :arel_field

    def initialize(arel_field)
      self.arel_field = arel_field
    end

    def >(other)
      arel_field.gt parse_other(other)
    end

    def >=(other)
      arel_field.gteq parse_other(other)
    end

    def <(other)
      arel_field.lt parse_other(other)
    end

    def <=(other)
      arel_field.lteq parse_other(other)
    end

    def ==(other)
      arel_field.eq parse_other(other)
    end

    def !=(other)
      arel_field.not_eq parse_other(other)
    end

    def =~(other)
      other = other.source if other.is_a?(Regexp)
      arel_field.matches_regexp parse_other(other)
    end

    def in?(other)
      arel_field.eq_any parse_other(other)
    end

    def method_missing(method_name, params = {})
      return arel_field.send(method_name, params) if arel_field.respond_to? method_name

      super
    end

    private

    def parse_other(other)
      other.is_a?(WhereIsArel) ? other.arel_field : other
    end
  end

  class WhereIs
    attr_accessor :result

    def initialize(arel, &block)
      @arel = arel
      self.result = instance_exec(&block)
    end

    def method_missing(method_name, _params = {})
      WhereIsArel.new @arel[method_name]
    end
  end

  class WhereChain
    def is(&block)
      arel_table = @scope.klass.arel_table

      @scope.where WhereIs.new(arel_table, &block).result
    end

    def is_not &block
      arel_table = @scope.klass.arel_table

      self.not WhereIs.new(arel_table, &block).result
    end
  end
end
