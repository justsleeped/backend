/**
 * @author Chen Qin
 * @license Apache-2.0
 */
package com.sealflow.common.handler;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Component
public class LockWebSocketHandler extends TextWebSocketHandler {

    private static WebSocketSession deviceSession;

    @Override
    public void afterConnectionEstablished(WebSocketSession session) {
        deviceSession = session;
        System.out.println("设备已连接");
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) {
        System.out.println("收到设备消息: " + message.getPayload());
    }

    public static void sendToDevice(String msg) throws Exception {
        if (deviceSession != null && deviceSession.isOpen()) {
            deviceSession.sendMessage(new TextMessage(msg));
        }
    }
}
