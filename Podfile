# Uncomment the next line to define a global platform for your project
platform :ios,   '9.0'
use_frameworks!

def shared_pods
  pod 'SwiftyDraw'
  pod 'FirebaseUI/Auth', '~> 8.0'
  pod 'FirebaseUI/OAuth',  '~> 8.0'
  pod 'Firebase/Firestore'
  pod 'FirebaseFirestoreSwift'
end

target 'Arnie MOCK' do

  shared_pods
  
  target 'Arnie Workout TrackerTests' do
    inherit! :search_paths
  end

  target 'Arnie Workout TrackerUITests' do
  end
  
end

target 'Arnie PROD' do
  
  shared_pods
  # pod 'Firebase/MLVision'
  
end

target 'Arnie INT' do
  
  shared_pods
  # pod 'Firebase/MLVision'
  
end
