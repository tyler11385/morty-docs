module Api
    class TemplatesController < ApplicationController
      before_action :authorize_request
  
      def index
        templates = Template.all
  
        # Optional filters
        templates = templates.where("name ILIKE ?", "%#{params[:name]}%") if params[:name].present?
        templates = templates.where(company_id: params[:company_id]) if params[:company_id].present?
  
        if Template::STATUSES.keys.map(&:to_s).include?(params[:status])
          templates = templates.where(status: Template::STATUSES[params[:status].to_sym])
        else
          templates = templates.where.not(status: Template::STATUSES[:archived])
        end
  
        render json: templates.as_json(only: [:id, :name, :status, :company_id, :created_at, :updated_at])
      end
  
      def show
        template = Template.find(params[:id])
        render json: template.as_json(include: :placeholders)
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Template not found" }, status: :not_found
      end
  
      def create
        @template = Template.new(template_params)
        @template.user = @current_user
        @template.company = @current_user.company
  
        if @template.save
          render json: @template, status: :created
        else
          Rails.logger.error("Template failed to save: #{@template.errors.full_messages}")
          render json: { errors: @template.errors.full_messages }, status: :unprocessable_entity
        end
      end
  
      def update
        template = Template.find(params[:id])
  
        if template.update(template_params)
          render json: template.as_json(include: :placeholders)
        else
          render json: { errors: template.errors.full_messages }, status: :unprocessable_entity
        end
      end
  
      def destroy
        template = Template.find(params[:id])
        template.destroy
        render json: { success: true }
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Template not found" }, status: :not_found
      end
  
      private
  
      def template_params
        params.require(:template).permit(:name, :content, :status)
      end
    end
  end
  