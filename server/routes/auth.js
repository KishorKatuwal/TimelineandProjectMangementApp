const express = require("express");
const User = require("../models/user");
const authRouter = express.Router();
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");
const auth = require("../middlewares/auth");

authRouter.post("/api/signup", async (req, res) => {
  try {
    //getting data from the client
    const { name, email, password, group, faculty } = req.body;
    //checking whether the user already exits or not
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res.status(400).json({ msg: "Already logged in" });
    }
    //8is like salt
    const hashedPassword = await bcryptjs.hash(password, 8);
    let user = new User({
      email,
      password: hashedPassword,
      name,
      group,
      faculty,
    });
    //post that data in the database
    user = await user.save();
    //return that data to the user
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

//api for singing in
authRouter.post("/api/signin", async (req, res) => {
  try {
    const { email, password } = req.body;
    //finding the user
    const user = await User.findOne({ email });
    if (!user) {
      return (
        res.status(400), json({ message: "User with this email not found" })
      );
    }

    //checking password
    const isMatch = bcryptjs.compare(password, user.password);
    if (!user) {
      return res.status(400), json({ msg: "Incorrect Password!" });
    }

    //what to give jwt to isgn in with
    const token = jwt.sign({ id: user._id }, "passwordKey");
    //...is object destructing
    res.json({ token, ...user._doc });



  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

    //checking token is valid
    authRouter.post("/tokenIsValid", async (req, res) => {
      try {
        const token = req.header("x-auth-token");
        if (!token) return res.json(false);
        const verified = jwt.verify(token, "passwordKey");
        if (!verified) return res.json(false);
        const user = await User.findById(verified.id);
        if (!user) return res.json(false);
        res.json(true);
      } catch (e) {
        res.status(500).json({ error: e.message });
      }
    });

    //get user data
    authRouter.get("/", auth, async (req, res) => {
      const user = await User.findById(req.user);
      res.json({ ...user._doc, token: req.token });
    });


module.exports = authRouter;
