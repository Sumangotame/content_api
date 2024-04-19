class Api::V1::ContentsController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :authorize_user, only: [:update,:destroy]
    before_action :set_content, only:[:update,:destroy]

    def index
        contents=Content.all.map do|content|
            {
                id: content.id,
                type: 'content',
                attributes: {
                  title: content.title,
                  body: content.body,
                  createdAt: content.created_at,
                  updatedAt: content.updated_at
                }
            }
        end
        render json:{ data:contents }
    end

    
    def create
        content=current_user.contents.build(content_params)
        if content.save
            render json:{
                "data": {
                    "id": content.id,
                    "type": "content",
                    "attributes": {
                        "title": content.title,
                        "body": content.body,   
                        "createdAt": content.created_at,
                        "updatedAt": content.updated_at
                    }
                }
            }, status: :created
        else
            render json: {errors:content.errors}, status: :unprocessable_entity
        end
    end


    def update
           if @content.update(content_params)
            render json:{
                "data": {
                  "id": @content.id,
                  "type": "content",
                  "attributes": {
                      "title": @content.title,
                      "body": @content.body,
                      "createdAt": @content.created_at,
                      "updatedAt": @content.updated_at
                  }
                }
              }, status: :ok
            else
                render json: { errors: @content.errors }, status: :unprocessable_entity
            end
    end


    def destroy
        if @content.destroy
            render json:{ message: 'Deleted' },status: :ok
        else
            render json:{ errors:'failed to delete content'}, status: :unprocessable_entity
        end
    end

    
    private

    def authorize_user
        set_content
        render json:{error: "unauthorized"}, status: :unauthorized unless @content.user_id == current_user.id
    end

    def set_content
        @content=Content.find(params[:id])
    end

    def content_params
        params.require(:content).permit(:title, :body)
    end

end
