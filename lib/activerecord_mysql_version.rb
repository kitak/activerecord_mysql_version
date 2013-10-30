require "activerecord_mysql_version/version"

module ActiveRecord
  class Base
    class << self
      def mysql4?
        mysql_version > '4.0' && mysql_version < '5.0' if use_mysql?
      end

      def mysql5?
        mysql_version > '5.0' && mysql_version < '6.0' if use_mysql?
      end

      def mysql_version
        @mysql_version ||= fetch_mysql_version
      end

      private
      def fetch_mysql_version
        self.connection.select_value('SELECT VERSION()') if use_mysql?
      end

      def use_mysql?
        defined?(::Mysql) || defined?(::Mysql2)
      end
    end

    def mysql4?
      self.class.mysql4?
    end

    def mysql5?
      self.class.mysql5?
    end

    def mysql_version
      self.class.mysql_version
    end
  end
end

