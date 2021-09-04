const { exec } = require('child_process')

module.exports = app => {
  app.log('kcdata-bot started!')

  app.on('issues.labeled', async context => {
    const { number } = context.payload.issue
    const triggered = context.payload.issue.labels.some(label => label.name === 'bot/update')
    if (!triggered) return

    exec(`sh ./script/run.sh ${number}`, (err, stdout) => {
      if (err) {
        console.error(err)
        return
      }
      console.log(stdout)
      const pr = context.octokit.pulls.create({
        owner: 'kcwikizh',
        repo: 'kcdata',
        head: `bot-update-${number}`,
        base: 'gh-pages',
        maintainer_can_modify: true,
        title: 'Update data by kcdata-bot',
        body: `Triggered by #${number}\nMerge 前请务必检查内容是否填写完整。（例如：wiki_id是否填写完全）`
      })
      const issueComment = context.issue({ body: 'Done.' })
      return context.octokit.issues.createComment(issueComment)
    })
  })
}
