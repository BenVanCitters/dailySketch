#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup()
{
     ofBackground(200,50,190);
    for(int i = 0; i < lineCount; i++)
    {
        ofPolyline line;
        vLines.push_back(line);
    }
    
    for(int i = 0; i < lineCount; i++)
    {
        ofPolyline line;
        hLines.push_back(line);
    }
}

//--------------------------------------------------------------
void ofApp::update()
{
    float tm = ofGetElapsedTimef()/10.f;
    float w = ofGetWindowWidth();
    float h = ofGetWindowHeight();
    
    float vertSpacing = h/(lineCount-1);
    float horzSpacing = w/(vertCount-1);
    int y = 0;
    for (std::vector<ofPolyline>::iterator it = vLines.begin() ; it != vLines.end(); ++it)
    {
        it->clear();
        for(int i = 0; i < vertCount; i++)
        {
            ofPoint pt;
            
            pt.set(i*horzSpacing,y*vertSpacing);
            ofPoint noisept = pt/80.f;
            ofVec2f noise(ofNoise(noisept.x, noisept.y,0,tm),
                          ofNoise(noisept.x, noisept.y,1,tm));
            noise -= .5;
            noise *= 80;
            
            it->addVertex(pt+noise);
        }
        y++;
    }



    vertSpacing = h/(vertCount-1);
    horzSpacing = w/(lineCount-1);
    y = 0;
    for (std::vector<ofPolyline>::iterator it = hLines.begin() ; it != hLines.end(); ++it)
    {
        it->clear();
        for(int i = 0; i < vertCount; i++)
        {
            ofPoint pt;
            
            pt.set(y*horzSpacing,
                   i*vertSpacing);
            ofPoint noisept = pt/80.f;
            ofVec2f noise(ofNoise(noisept.x, noisept.y,0,tm),
                          ofNoise(noisept.x, noisept.y,1,tm));
            noise -= .5;
            noise *= 80;
            
            it->addVertex(pt+noise);
        }
        y++;
    }

}

//--------------------------------------------------------------
void ofApp::draw()
{
    ofSetColor(0,0,120,255);
    for (ofPolyline line : vLines)
    {
        line.draw();
    }
    
    ofSetColor(255,0,0,255);
    for (ofPolyline line : hLines)
    {
        line.draw();
    }
}

//--------------------------------------------------------------
void ofApp::keyPressed(int key){

}

//--------------------------------------------------------------
void ofApp::keyReleased(int key){

}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y ){

}

//--------------------------------------------------------------
void ofApp::mouseDragged(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mouseReleased(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mouseEntered(int x, int y){

}

//--------------------------------------------------------------
void ofApp::mouseExited(int x, int y){

}

//--------------------------------------------------------------
void ofApp::windowResized(int w, int h){

}

//--------------------------------------------------------------
void ofApp::gotMessage(ofMessage msg){

}

//--------------------------------------------------------------
void ofApp::dragEvent(ofDragInfo dragInfo){ 

}
