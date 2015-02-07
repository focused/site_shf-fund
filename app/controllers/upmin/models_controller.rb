require_dependency "upmin/application_controller"
require_dependency "./app/helpers/upmin/models_helper"

module Upmin
  class ModelsController < ApplicationController
    before_action :set_klass, only: [:new, :create, :show, :update, :destroy, :search, :action]
    before_action :set_model, only: [:show, :update, :destroy, :action]

    before_action :set_parent, only: [:search]
    before_action :set_page, only: [:search]
    before_action :set_query, only: [:search]
    before_action :set_q_for_form_values, only: [:search]

    before_action :set_action, only: [:action]
    before_action :set_arguments, only: [:action]

    def dashboard
    end

    # GET /:model_name/:id
    def show
      # set_parent_url unless params[:parent_id]
    end

    # GET /:model_name/new
    def new
      @model = @klass.new
    end

    # POST /:model_name
    def create
      @model = @klass.new
      raw_model = @model.model

      args = params[@klass.underscore_name]

      args.each do |key, value|
        # TODO(jon): Figure out a way to do transforms.

        # TODO(jon): Remove duplicate code between update and create
        if args["#{key}_is_nil"] == "1"
          raw_model.send("#{key}=", nil)
        else
          if key.ends_with?("_is_nil")
            # Skip this, since we use the non _is_nil arg.
          else
            raw_model.send("#{key}=", value)
          end
        end
      end

      if raw_model.save
        flash[:notice] = "Запись создана (id=#{raw_model.id})."
        redirect_to @model.path
      else
        flash.now[:alert] = "Запись не была создана."
        render(:new)
      end
    end

    # PUT /:model_name/:id
    def update

      raw_model = @model.model
      updates = params[@klass.underscore_name]

      updates.each do |key, value|
        # TODO(jon): Remove duplicate code between update and create
        if updates["#{key}_is_nil"] == "1"
          raw_model.send("#{key}=", nil)
        else
          if key.ends_with?("_is_nil")
            # Skip this, since we use the non _is_nil arg.
          else
            raw_model.send("#{key}=", value)
          end
        end
      end

      if raw_model.save
        flash[:notice] = "Запись изменена."
        redirect_to @model.path
      else
        flash.now[:alert] = "Запись не была изменена."
        render(:show)
      end
    end

    def search
      # set_parent_url
      # @q = @klass.ransack(params[:q])
      # @results = Upmin::Paginator.paginate(@q.result(distinct: true), @page, 30)
    end

    # DELETE /:model_name/:id
    def destroy
      raw_model = @model.model
      #destroy does not work when using datamapper and have associations but destroy! works fine
      #destroy! does not exist in ActiveRecord
      if defined?(raw_model.destroy!)
        @result = raw_model.destroy! #data mapper
      else
        @result = raw_model.destroy #active record
      end
      if @result
        flash.now[:notice] = "Запись удалена."
        redirect_to "#{@klass.search_path}?parent_id=#{raw_model.parent_id}"
      else
        flash.now[:alert] = "Запись не была удалена."
        render(:show)
      end
    end

    def action
      @response = @action.perform(@arguments)

      flash[:notice] = "Действие выполнено: #{@response}"
      redirect_to(@model.path)
      # rescue Exception => e
      #   flash.now[:alert] = "Action failed with the error message: #{e.message}"
      #   render(:show)
      # end
    end

    private
      def set_parent
        if params[:parent_id]
          params[:q] ||= {}
          params[:q][:product_category_id_lteq] = params[:parent_id]
          params[:q][:product_category_id_gteq] = params[:parent_id]
        end
      end

      # def set_parent_url
      #   session[:parent_url] = request.url
      # end

      # TODO(jon): Make the search form fill better than openstruct impl.
      # Temporarily preserve most search form values. This will break if
      # someone wants to search for "2014-09-05" as a string :(
      def set_q_for_form_values
        if params[:q]
          q_hash = params[:q].dup
          q_hash.each do |key, value|
            if value.to_s.match(/[0-9]{4}\-[0-9]{2}\-[0-9]{2}/)
              q_hash[key] = DateTime.parse(value)
            end
          end
          @q = OpenStruct.new(q_hash)
        end
      end

      def set_query
        @query = Upmin::Query.new(@klass, params[:q], page: @page, per_page: @klass.items_per_page)
      end

      def set_model
        @model = @klass.new(id: params[:id])
      end

      def set_klass
        @klass = Upmin::Model.find_class(params[:klass])
      end

      def set_action
        action_name = params[:method]
        @action = @model.actions.select{ |action| action.name.to_s == action_name }.first

        raise Upmin::InvalidAction.new(params[:method]) unless @action
      end

      def set_arguments
        arguments = params[@action.name] || {}
        @arguments = {}
        arguments.each do |k, v|
          unless k.ends_with?("_is_nil")
            if arguments["#{k}_is_nil"] != "1"
              @arguments[k] = v
            end
          end
        end
        @arguments = ActiveSupport::HashWithIndifferentAccess.new(@arguments)
      end

      def set_page
        @page = params[:page] || 1
      end

      # TODO(jon): Figure out a better way to do transforms that is easy to extend.
      def transform(transforms, key, value)
        split = transforms[key].split('#')
        klass = eval(split[0])
        method = split[1]
        return klass.send(method, value)
      end
  end
end

