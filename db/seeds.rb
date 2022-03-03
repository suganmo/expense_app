User.create!(name: "管理者",
  email: "admin@email.com",
  password: "password",
  password_confirmation: "password",
  admin: true,
  superior: false,)
  
User.create!(name: "上長A",
  email: "superior1@email.com",
  password: "password",
  password_confirmation: "password",
  admin: false,
  superior: true,)