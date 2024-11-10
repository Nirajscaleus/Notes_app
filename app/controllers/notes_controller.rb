class NotesController < ApplicationController
   
    def index
        if user_signed_in?
          @notes = current_user.notes
        else
           @notes = Note.all 
        end
    end
    def new
      @note = Note.new
    end
    def show
        @note = Note.find(params[:id])
    end

    def create
        
        @note = Note.new(notes_params)
        if @note.save
        redirect_to @note, notice: 'notes was successfully created.'
        else
        render :new, status: :unprocessable_entity
        end
    end
    def edit
      @note = Note.find(params[:id])
    end

    def update
     @note = Note.find(params[:id])
    if @note.update(notes_params)
        redirect_to @note
    else
        render :edit, status: :unprocessable_entity
    end
    end

    def destroy
        @note = Note.find(params[:id])
        @note.destroy

        redirect_to root_path, status: :see_other
    end
    
    private
    def notes_params
        params.require(:note).permit(:title,:date,:description,:user_id)
    end
    
end
    
