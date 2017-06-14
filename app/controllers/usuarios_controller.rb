class UsuariosController < ApplicationController
  before_action :set_usuario, only: [:show, :edit, :update, :destroy]

  # GET /usuarios
  # GET /usuarios.json
  def index
    if current_cuentum.email = "admin@admin.com"
      @usuarios = Usuario.all
      @div_admin = true
    end
    @usuariosAux = Usuario.all
    @cuentas = Cuentum.all
    @usuariosAux.each do |u| 
        if cuentum_signed_in? && current_cuentum.id == u.cuenta_id
          if u.rol == "ADMINISTRADOR"
            @usuarios = @usuariosAux
            @div_admin = true
          end
          if u.rol == "USUARIO" || u.rol == "OPERARIO"
            @usuarios = []
            @usuarios << u
          end
        end
    end
  end

  # GET /usuarios/1
  # GET /usuarios/1.json
  def show
  end

  # GET /usuarios/new
  def new
    @usuario = Usuario.new

  end

  # GET /usuarios/1/edit
  def edit
  end

  # POST /usuarios
  # POST /usuarios.json
  def create
      @usuario = Usuario.new(usuario_params)
      @usuario.nombres =  @usuario.nombres.upcase
      @usuario.apellidos =  @usuario.apellidos.upcase
      respond_to do |format|
        if @usuario.save
          format.html { redirect_to @usuario, notice: 'El Usuario se ha creado correctamente.' }
          format.json { render :show, status: :created, location: @usuario }
        else
          format.html { render :new }
          format.json { render json: @usuario.errors, status: :unprocessable_entity }
        end
      end
    
  end

  # PATCH/PUT /usuarios/1
  # PATCH/PUT /usuarios/1.json
  def update
    respond_to do |format|
      if @usuario.update(usuario_params)
        format.html { redirect_to @usuario, notice: 'El Usuario se ha editado correctamente.' }
        format.json { render :show, status: :ok, location: @usuario }
      else
        format.html { render :edit }
        format.json { render json: @usuario.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /usuarios/1
  # DELETE /usuarios/1.json
  def destroy
    @usuario.destroy
    respond_to do |format|
      format.html { redirect_to usuarios_url, notice: 'El Usuario se ha eliminado correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_usuario
      @usuario = Usuario.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def usuario_params
      params.require(:usuario).permit(:ci, :nombres, :apellidos, :rol, :habilitado, :empresa_id, :cuenta_id)
    end
end
