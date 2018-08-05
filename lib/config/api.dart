const String apiHost = 'https://www.v2ex.com/api';

const Map<String, String> apis = {
  'latest_topics': '$apiHost/topics/latest.json',
  'hot_topics': '$apiHost/topics/hot.json',
  'topic': '$apiHost/topics/show.json',
  "replies": '$apiHost/replies/show.json',
  'nodes': '$apiHost/nodes/all.json',
  'signin': 'https://v2x-api.now.sh/signin'
};