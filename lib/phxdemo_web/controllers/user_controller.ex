defmodule PhxdemoWeb.UserController do
  use PhxdemoWeb, :controller

  alias Phxdemo.Users
  alias Phxdemo.Users.User

  action_fallback PhxdemoWeb.FallbackController

  @apidoc """
  @apiDefine UserNotFoundError

  @apiError UserNotFound The id of the User was not found.

  @apiErrorExample Error-Response:
      HTTP/1.1 404 Not Found
      {
        "message": "Not Found"
      }
  """

  @apidoc """
  @apiDefine DefaultHeader

  @apiHeader Content-Type application/json.
  """

  @apidoc """
  @apiDefine AuthorizationHeader

  @apiHeader Authorization Authorization Bearer token.
  @apiHeaderExample {json} Header-Example:
    {
      "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1MTYyMTk5NjEsImlhdCI6MTUxNjIxMjc2MX0.ytDiDZ2EFua46ifCevXZH9YjL8CnlCPLoecIodD5d-w"
    }
  """

  @apidoc """
  @apiDefine InvalidAuthorizationError

  @apiError InvalidAuthorization Invalid Token

  @apiErrorExample Error-Response:
      HTTP/1.1 401 Not Found
      {
        "message": "Invalid authorization"
      }
  """

  @apidoc """
  @apiDefine private User access only
  Requires a authorization bearer token with a valid jwt.
  """

  def index(conn, _params) do
    users = Users.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, user_params) do
    with {:ok, %User{} = user} <- Users.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  @apidoc """
  @api {get} /user/:id Request User information
  @apiName GetUser
  @apiGroup User

  @apiParam {Number} id Users unique ID.

  @apiSuccess {Number} id   User unique ID.
  @apiSuccess {Number} age  Age of the User.
  @apiSuccess {String} name Name of the User.
  @apiSuccessExample Success-Response:
      HTTP/1.1 200 OK
      {
        "firstname": "John",
        "lastname": "Doe"
      }

  @apiUse UserNotFoundError
  @apiUse InvalidAuthorizationError
  @apiUse AuthorizationHeader
  @apiUse DefaultHeader
  @apiPermission private
  """
  def show(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, user_params) do
    user = Users.get_user!(user_params["id"])

    with {:ok, %User{} = user} <- Users.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    with {:ok, %User{}} <- Users.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
