---
date: 2024-05-13 22:54
---

# Change Freezes Done Right

In many mature companies, the product development process is often halted for a period to avoid changes that could impact product stability and, consequently, the company's business during critical times. Think of changes to the Steam store on Christmas or adjustments to the Amazon website on Black Friday.

You can find a good article on this practice [here](https://edworking.com/blog/productivity/how-and-why-to-prepare-for-a-change-freeze).

*Note: Yes, I am aware that a change freeze doesn't necessarily mean stop working. On the contrary, many people still do a bunch of work during these periods; they just can't deploy that work into production. In most cases, teams deploy things into development environments and then wait for the end of the freeze to deploy everything.*

Despite being a good practice, I am slightly against it in the models companies use, and this note is to state what I think it should be instead under normal circumstances (there are obvious exceptions at times that might justify freezing everything):

1. **Duration**: The period should be short, ideally a week or two. Anything longer is a sign of a broken process, a flawed code base, or inadequate tools. People can ignore it, sure, but the root cause of instability still exists and will impact the product regardless of the change freeze.
   1. There is an obvious exception for when the critical period extends longer, but you get the idea. In the example of Steam given above, perhaps the period is justified to be longer than 2 weeks during Christmas because it's not only on Christmas Eve people buy games - but more so during the whole holiday season.
2. **Allowing Changes**: Despite typically no one being allowed to make changes, some teams' work does not really impact the product. As such, this concept should be reviewed based on two main factors:
   1. The nature of the team's work - DevOps teams can impact the CI/CD but rarely the product itself (depends on the work, obviously; they aren't going to do some database upgrades in this period). But I don't understand the problem with continuing to work on platform automation, for instance. Again, with the right balance, things should still be possible.
   2. **The history of the team or tribe's responsibility causing incidents in the past**.

This last point is critical and is a game-changer for most. Teams that cause instability over time should be incentivized to fix their processes, tools, and/or products. Maybe this will make them rethink their technical debt, enabling them to work during these periods. Of course, this might not suffice, but at least it doesn't impact other teams' work if we take into account the other suggestions. Some may say this is a form of finger-pointing, but I find it reasonable enough to be worth it. It's a form of gamification and a way to make people think about the consequences of their processes, tools, and products (including the code base).

I'm not judging those who do their best to keep things running and are hands-tied to actually fix them. Companies nowadays often throw money at problems when sometimes they should just solve the problems instead. I'm a fan of KISS, so I work wholeheartedly to make the things I work on simple and easy to work with. I'm happy when a colleague mentions that a given process, tool, or whatever is well-documented, allowing them to understand where they should be headed and get their work done. It's really painful to maintain legacy things, and I truthfully wonder if it doesn't cost more money maintaining the legacy instead of fixing things around. Perhaps the business can't stop entirely to make it work, but maybe improving things gradually is the way to go. Neither seems to happen, and then high-level management came up with change freezes, which stops everyone from continuing with the agile lifecycle.


