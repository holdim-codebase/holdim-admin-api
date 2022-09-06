import { PubSub } from '@google-cloud/pubsub'
import { Proposal as DBProposal } from '@prisma/client'
import { config } from '../config'

export const queueAccepted = async (proposal: DBProposal) => {
  const pubsub = new PubSub()
  const topic = pubsub.topic(config.pubsub.toUpdater.topicNameOrId)
  await topic.publishMessage({
    json: {
      id: proposal.id,
      juniorDescription: proposal.juniorDescription,
      setIssueNumber: true,
    },
  })
}

export const queueEdited = async (proposal: DBProposal, newSeniorDescription: string) => {
  const pubsub = new PubSub()
  const topic = pubsub.topic(config.pubsub.toAi.topicNameOrId)
  await topic.publishMessage({
    json: {
      id: proposal.id,
      seniorDescription: newSeniorDescription,
    },
  })
}
