##
# Notes Controller: Note crud operations
#
class NotesController < ApplicationController
  before_action :authenticate_user
  before_action :set_note, only: [:show, :edit,:update, :destroy, :open_spreadsheet]

  def index
    @notes = current_user.notes
  end

  def show
  end

  # GET /notes/new
  def new
    @note = Note.new
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes : Register new note
  def create
    @note = Note.new(note_params)
    @note.user = current_user

    respond_to do |format|
      if @note.save
        format.html { redirect_to @note, notice: 'note was successfully created.' }
        format.json { render :show, status: :created, location: @note }
      else
        format.html { render :new }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1
  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to @note, notice: 'Note was successfully updated.' }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

    # DELETE /notes/1
  def destroy
      @note.destroy
      respond_to do |format|
        format.html { redirect_to notes_url, notice: 'Note was successfully destroyed.' }
        format.json { head :no_content }
      end
  end

  def open_spreadsheet
    puts @note.title
    session = GoogleDrive::Session.from_config("config.json")

    # First worksheet of
    ws = session.spreadsheet_by_key("12WrwspcM_bu1ZYwYn4hKBKw831ofkcIB3OVB19XQ6SQ").worksheets[0]
    puts ws
    ws[2, 1]= @note.body
  end

  def save_note_callback
    session = GoogleDrive::Session.from_config("config.json")
    ws = session.spreadsheet_by_key("12WrwspcM_bu1ZYwYn4hKBKw831ofkcIB3OVB19XQ6SQ").worksheets[0]
    # read note body
    note_body = ws[2, 1]
    #TODO: Save it to DB
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def note_params
      params.require(:note).permit(:title, :body)
    end
end
