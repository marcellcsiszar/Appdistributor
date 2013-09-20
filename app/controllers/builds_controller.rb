class BuildsController < ApplicationController
  before_filter :authenticate_user!
  require 'ruby_apk'
  require 'ipa'
  before_action :set_build, only: [:show, :edit, :update, :destroy]
  # GET /builds
  # GET /builds.json
  def index
    @builds = Build.all
  end

  # GET /builds/1
  # GET /builds/1.json
  def show
  end

  # GET /builds/new
  def new
    @project = Project.find(params[:project_id])
    @build = @project.builds.build
  end

  # GET /builds/1/edit
  def edit
  end

  # POST /builds
  # POST /builds.json
  def create
    @project = Project.find(params[:project_id])
    @build = @project.builds.build(build_params)
    @build.platform = if @build.package.mime_type == "application/vnd.android.package-archive"
    then "Android" elsif @build.package.mime_type == "application/octet-stream"; then "iOS" else "@build.package.mime_type" end
    if @build.platform == "Android"
      @apk = Android::Apk.new(@build.package.file)
      @build.bundleID = @apk.manifest.package_name
      @build.icon = @apk.icon.values.last
      @build.version = @apk.manifest.version_code
      @build.packagename = @apk.resource.find(@apk.manifest.label)
      @build.taken = @apk.time
    elsif @build.platform == "iOS"
      @ipa = IPA::IPAFile.new(@build.package.file);
      @build.bundleID = @ipa.identifier
      begin
        @build.icon = @ipa.artwork
      rescue Errno::ENOENT
        @build.icon_url = "http://placehold.it/50x50"
      end
      #@build.icon = Zip::ZipFile.new(@build.package.file).read("Payload/"+@ipa.display_name.to_s+".app/"+@ipa.icon_paths.first.to_s+".png") if @ipa.icon_path
      #@build.icon = Zip::ZipFile.new(@build.package.file).read("Payload/"+@ipa.display_name.to_s+".app/"+@ipa.icon_path.to_s+".png") if @ipa.icon_path
      @build.version = @ipa.version_string
      @build.packagename = @ipa.display_name
      @build.taken = File.ctime(@build.package.file)
    end


    respond_to do |format|
      if @build.save
        format.html { redirect_to @project, notice: 'Build was successfully created.' }
        format.json { render action: 'show', status: :created, location: @project }
      else
        format.html { render action: 'new' }
        format.json { render json: @build.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /builds/1
  # PATCH/PUT /builds/1.json
  def update
    respond_to do |format|
      if @build.update(build_params)
        format.html { redirect_to @build, notice: 'Build was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @build.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /builds/1
  # DELETE /builds/1.json
  def destroy
    @build.destroy
    respond_to do |format|
      format.html { redirect_to builds_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_build
    @build = Build.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def build_params
    params[:build].permit(:package,:package_uid,:icon,:icon_uid,:taken,:project,:platform,:version,:bundleID,:packagename)
  end
end
