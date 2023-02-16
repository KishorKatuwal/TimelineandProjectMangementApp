const express = require('express');
const adminRouter = express.Router();
const admin = require('../middlewares/admin');
const Feedback  = require('../models/feedback');


//fetching feedback
adminRouter.get('/admin/get-feedback', admin, async (req, res) => {
    try {
        const feedbacks = await Feedback.find({});
        res.json(feedbacks);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});







module.exports = adminRouter;