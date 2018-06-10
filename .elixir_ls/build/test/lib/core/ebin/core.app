{application,core,
             [{applications,[kernel,stdlib,elixir,logger,ex_machina,
                             eventstore,runtime_tools,vex,poison,
                             exconstructor,bcrypt_elixir,comeonin,timex,
                             httpoison,slugger,uuid,commanded,postgrex,ecto,
                             timex_ecto,commanded_ecto_projections,
                             commanded_eventstore_adapter]},
              {description,"core"},
              {modules,['Elixir.Core','Elixir.Core.Ability',
                        'Elixir.Core.Ability.Projections.Level',
                        'Elixir.Core.Ability.Projections.Switch',
                        'Elixir.Core.Accounts',
                        'Elixir.Core.Accounts.Aggregates.Role',
                        'Elixir.Core.Accounts.Aggregates.User',
                        'Elixir.Core.Accounts.Commands.CreateRole',
                        'Elixir.Core.Accounts.Commands.RegisterUser',
                        'Elixir.Core.Accounts.Commands.UpdateRole',
                        'Elixir.Core.Accounts.Commands.UpdateUser',
                        'Elixir.Core.Accounts.Events.RoleCreated',
                        'Elixir.Core.Accounts.Events.RoleDescriptionChanged',
                        'Elixir.Core.Accounts.Events.RoleLabelChanged',
                        'Elixir.Core.Accounts.Events.RoleNameChanged',
                        'Elixir.Core.Accounts.Events.UserEmailChanged',
                        'Elixir.Core.Accounts.Events.UserPasswordChanged',
                        'Elixir.Core.Accounts.Events.UserRegistered',
                        'Elixir.Core.Accounts.Events.UserRoleChanged',
                        'Elixir.Core.Accounts.Events.UserUsernameChanged',
                        'Elixir.Core.Accounts.Projections.Role',
                        'Elixir.Core.Accounts.Projections.User',
                        'Elixir.Core.Accounts.Projectors.Role',
                        'Elixir.Core.Accounts.Projectors.Role.ProjectionVersion',
                        'Elixir.Core.Accounts.Projectors.User',
                        'Elixir.Core.Accounts.Projectors.User.ProjectionVersion',
                        'Elixir.Core.Accounts.Queries.ListRoles',
                        'Elixir.Core.Accounts.Queries.ListUsers',
                        'Elixir.Core.Accounts.Queries.RoleByName',
                        'Elixir.Core.Accounts.Queries.UserByEmail',
                        'Elixir.Core.Accounts.Queries.UserByUsername',
                        'Elixir.Core.Accounts.Supervisor',
                        'Elixir.Core.Accounts.Validators.UniqueEmail',
                        'Elixir.Core.Accounts.Validators.UniqueRoleName',
                        'Elixir.Core.Accounts.Validators.UniqueUsername',
                        'Elixir.Core.AggregateCase','Elixir.Core.Application',
                        'Elixir.Core.Auth',
                        'Elixir.Core.Auth.GuardianSerializer',
                        'Elixir.Core.DataCase','Elixir.Core.Factory',
                        'Elixir.Core.Fixture','Elixir.Core.People',
                        'Elixir.Core.People.Aggregates.Profile',
                        'Elixir.Core.People.Commands.CreateProfile',
                        'Elixir.Core.People.Commands.UpdateProfile',
                        'Elixir.Core.People.Events.ProfileCreated',
                        'Elixir.Core.People.Events.ProfileFirstNameChanged',
                        'Elixir.Core.People.Events.ProfileLastNameChanged',
                        'Elixir.Core.People.Events.ProfileUserChanged',
                        'Elixir.Core.People.Events.ProfileUsernameChanged',
                        'Elixir.Core.People.Projections.Profile',
                        'Elixir.Core.People.Projectors.Profile',
                        'Elixir.Core.People.Projectors.Profile.ProjectionVersion',
                        'Elixir.Core.People.Queries.ListProfiles',
                        'Elixir.Core.People.Supervisor',
                        'Elixir.Core.People.Workflows.CreateProfileFromUser',
                        'Elixir.Core.Places',
                        'Elixir.Core.Places.Aggregates.Location',
                        'Elixir.Core.Places.Aggregates.Room',
                        'Elixir.Core.Places.Aggregates.Zone',
                        'Elixir.Core.Places.Commands.CreateLocation',
                        'Elixir.Core.Places.Commands.CreateRoom',
                        'Elixir.Core.Places.Commands.CreateZone',
                        'Elixir.Core.Places.Commands.DeleteLocation',
                        'Elixir.Core.Places.Commands.DeleteRoom',
                        'Elixir.Core.Places.Commands.DeleteZone',
                        'Elixir.Core.Places.Commands.UpdateLocation',
                        'Elixir.Core.Places.Commands.UpdateRoom',
                        'Elixir.Core.Places.Commands.UpdateZone',
                        'Elixir.Core.Places.Events.LocationAddressCityChanged',
                        'Elixir.Core.Places.Events.LocationAddressOneChanged',
                        'Elixir.Core.Places.Events.LocationAddressStateChanged',
                        'Elixir.Core.Places.Events.LocationAddressTwoChanged',
                        'Elixir.Core.Places.Events.LocationAddressZipChanged',
                        'Elixir.Core.Places.Events.LocationCreated',
                        'Elixir.Core.Places.Events.LocationDeleted',
                        'Elixir.Core.Places.Events.LocationDescriptionChanged',
                        'Elixir.Core.Places.Events.LocationNameChanged',
                        'Elixir.Core.Places.Events.RoomCreated',
                        'Elixir.Core.Places.Events.RoomDeleted',
                        'Elixir.Core.Places.Events.RoomDescriptionChanged',
                        'Elixir.Core.Places.Events.RoomNameChanged',
                        'Elixir.Core.Places.Events.RoomZoneChanged',
                        'Elixir.Core.Places.Events.ZoneCreated',
                        'Elixir.Core.Places.Events.ZoneDeleted',
                        'Elixir.Core.Places.Events.ZoneDescriptionChanged',
                        'Elixir.Core.Places.Events.ZoneLocationChanged',
                        'Elixir.Core.Places.Events.ZoneNameChanged',
                        'Elixir.Core.Places.Projections.Location',
                        'Elixir.Core.Places.Projections.Room',
                        'Elixir.Core.Places.Projections.Zone',
                        'Elixir.Core.Places.Projectors.Location',
                        'Elixir.Core.Places.Projectors.Location.ProjectionVersion',
                        'Elixir.Core.Places.Projectors.Room',
                        'Elixir.Core.Places.Projectors.Room.ProjectionVersion',
                        'Elixir.Core.Places.Projectors.Zone',
                        'Elixir.Core.Places.Projectors.Zone.ProjectionVersion',
                        'Elixir.Core.Places.Queries.ListLocations',
                        'Elixir.Core.Places.Queries.ListRooms',
                        'Elixir.Core.Places.Queries.ListZones',
                        'Elixir.Core.Places.Supervisor','Elixir.Core.Repo',
                        'Elixir.Core.Router','Elixir.Core.Services',
                        'Elixir.Core.Services.Projections.Connection',
                        'Elixir.Core.Services.Projections.Provider',
                        'Elixir.Core.Storage',
                        'Elixir.Core.Support.Middleware.Uniqueness',
                        'Elixir.Core.Support.Middleware.Uniqueness.UniqueFields',
                        'Elixir.Core.Support.Middleware.Uniqueness.UniqueFields.Any',
                        'Elixir.Core.Support.Middleware.Uniqueness.UniqueFields.Core.Accounts.Commands.CreateRole',
                        'Elixir.Core.Support.Middleware.Uniqueness.UniqueFields.Core.Accounts.Commands.RegisterUser',
                        'Elixir.Core.Support.Middleware.Uniqueness.UniqueFields.Core.Accounts.Commands.UpdateRole',
                        'Elixir.Core.Support.Middleware.Uniqueness.UniqueFields.Core.Accounts.Commands.UpdateUser',
                        'Elixir.Core.Support.Middleware.Validate',
                        'Elixir.Core.Support.Unique',
                        'Elixir.Core.Support.Validators.String',
                        'Elixir.Core.Support.Validators.Uuid',
                        'Elixir.Core.Thing','Elixir.Core.Things.Entity',
                        'Elixir.Poison.Encoder.Core.Accounts.Events.RoleCreated',
                        'Elixir.Poison.Encoder.Core.Accounts.Events.RoleDescriptionChanged',
                        'Elixir.Poison.Encoder.Core.Accounts.Events.RoleLabelChanged',
                        'Elixir.Poison.Encoder.Core.Accounts.Events.RoleNameChanged',
                        'Elixir.Poison.Encoder.Core.Accounts.Events.UserEmailChanged',
                        'Elixir.Poison.Encoder.Core.Accounts.Events.UserPasswordChanged',
                        'Elixir.Poison.Encoder.Core.Accounts.Events.UserRegistered',
                        'Elixir.Poison.Encoder.Core.Accounts.Events.UserRoleChanged',
                        'Elixir.Poison.Encoder.Core.Accounts.Events.UserUsernameChanged',
                        'Elixir.Poison.Encoder.Core.People.Events.ProfileCreated',
                        'Elixir.Poison.Encoder.Core.People.Events.ProfileFirstNameChanged',
                        'Elixir.Poison.Encoder.Core.People.Events.ProfileLastNameChanged',
                        'Elixir.Poison.Encoder.Core.People.Events.ProfileUserChanged',
                        'Elixir.Poison.Encoder.Core.People.Events.ProfileUsernameChanged',
                        'Elixir.Poison.Encoder.Core.Places.Events.LocationAddressCityChanged',
                        'Elixir.Poison.Encoder.Core.Places.Events.LocationAddressOneChanged',
                        'Elixir.Poison.Encoder.Core.Places.Events.LocationAddressStateChanged',
                        'Elixir.Poison.Encoder.Core.Places.Events.LocationAddressTwoChanged',
                        'Elixir.Poison.Encoder.Core.Places.Events.LocationAddressZipChanged',
                        'Elixir.Poison.Encoder.Core.Places.Events.LocationCreated',
                        'Elixir.Poison.Encoder.Core.Places.Events.LocationDeleted',
                        'Elixir.Poison.Encoder.Core.Places.Events.LocationDescriptionChanged',
                        'Elixir.Poison.Encoder.Core.Places.Events.LocationNameChanged',
                        'Elixir.Poison.Encoder.Core.Places.Events.RoomCreated',
                        'Elixir.Poison.Encoder.Core.Places.Events.RoomDeleted',
                        'Elixir.Poison.Encoder.Core.Places.Events.RoomDescriptionChanged',
                        'Elixir.Poison.Encoder.Core.Places.Events.RoomNameChanged',
                        'Elixir.Poison.Encoder.Core.Places.Events.RoomZoneChanged',
                        'Elixir.Poison.Encoder.Core.Places.Events.ZoneCreated',
                        'Elixir.Poison.Encoder.Core.Places.Events.ZoneDeleted',
                        'Elixir.Poison.Encoder.Core.Places.Events.ZoneDescriptionChanged',
                        'Elixir.Poison.Encoder.Core.Places.Events.ZoneLocationChanged',
                        'Elixir.Poison.Encoder.Core.Places.Events.ZoneNameChanged',
                        'Elixir.Vex.Blank.Core.Accounts.Commands.CreateRole',
                        'Elixir.Vex.Blank.Core.Accounts.Commands.RegisterUser',
                        'Elixir.Vex.Blank.Core.Accounts.Commands.UpdateRole',
                        'Elixir.Vex.Blank.Core.Accounts.Commands.UpdateUser',
                        'Elixir.Vex.Blank.Core.People.Commands.CreateProfile',
                        'Elixir.Vex.Blank.Core.People.Commands.UpdateProfile',
                        'Elixir.Vex.Blank.Core.Places.Commands.CreateLocation',
                        'Elixir.Vex.Blank.Core.Places.Commands.CreateRoom',
                        'Elixir.Vex.Blank.Core.Places.Commands.CreateZone',
                        'Elixir.Vex.Blank.Core.Places.Commands.DeleteLocation',
                        'Elixir.Vex.Blank.Core.Places.Commands.DeleteRoom',
                        'Elixir.Vex.Blank.Core.Places.Commands.DeleteZone',
                        'Elixir.Vex.Blank.Core.Places.Commands.UpdateLocation',
                        'Elixir.Vex.Blank.Core.Places.Commands.UpdateRoom',
                        'Elixir.Vex.Blank.Core.Places.Commands.UpdateZone',
                        'Elixir.Vex.Extract.Core.Accounts.Commands.CreateRole',
                        'Elixir.Vex.Extract.Core.Accounts.Commands.RegisterUser',
                        'Elixir.Vex.Extract.Core.Accounts.Commands.UpdateRole',
                        'Elixir.Vex.Extract.Core.Accounts.Commands.UpdateUser',
                        'Elixir.Vex.Extract.Core.People.Commands.CreateProfile',
                        'Elixir.Vex.Extract.Core.People.Commands.UpdateProfile',
                        'Elixir.Vex.Extract.Core.Places.Commands.CreateLocation',
                        'Elixir.Vex.Extract.Core.Places.Commands.CreateRoom',
                        'Elixir.Vex.Extract.Core.Places.Commands.CreateZone',
                        'Elixir.Vex.Extract.Core.Places.Commands.DeleteLocation',
                        'Elixir.Vex.Extract.Core.Places.Commands.DeleteRoom',
                        'Elixir.Vex.Extract.Core.Places.Commands.DeleteZone',
                        'Elixir.Vex.Extract.Core.Places.Commands.UpdateLocation',
                        'Elixir.Vex.Extract.Core.Places.Commands.UpdateRoom',
                        'Elixir.Vex.Extract.Core.Places.Commands.UpdateZone']},
              {registered,[]},
              {vsn,"0.1.0"},
              {mod,{'Elixir.Core.Application',[]}},
              {extra_applications,[logger,ex_machina,eventstore,
                                   runtime_tools]}]}.