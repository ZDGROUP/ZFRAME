/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ZF_API_VOIP;

import java.io.IOException;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CopyOnWriteArrayList;
import javax.websocket.CloseReason;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint(value = "/VOIP/{user}")
public class ZF_VOIP {
    public static Map<String, Session> oSockets = new Hashtable<String, Session>();
    public static List<String> oUsers = new CopyOnWriteArrayList<String>();

    @OnOpen
    public void onOpen(Session session, @PathParam("user") String sUserId) throws IOException {
        if (oSockets.containsKey(sUserId)) {
            session.close(new CloseReason(CloseReason.CloseCodes.CANNOT_ACCEPT, "User " + sUserId + " already logged in"));
            return;
        }

        oSockets.put(sUserId, session);
        oUsers.add(sUserId);

        // Send RefreshUsers Msg to all users
        for (String sUser : oUsers) {
            Session oDestSocket = oSockets.get(sUser);
            if (oDestSocket != null) {
                oDestSocket.getBasicRemote().sendText("{{RefreshUsers}}");
            }
        }
    }

    @OnMessage
    public void onMessage(Session session, String sMsg) throws IOException {
        String sUserId = session.getPathParameters().get("user");

        boolean bSendMsgToAllUsers = !sMsg.equals("{{Ring}}");

        sMsg = sUserId + ": " + sMsg;

        for (String sUser : oUsers) {
            if (bSendMsgToAllUsers || !sUser.equals(sUserId)) {
                Session oDestSocket = oSockets.get(sUser);
                if (oDestSocket != null) {
                    oDestSocket.getBasicRemote().sendText(sMsg);
                }
            }
        }
    }

    @OnClose
    public void onClose(Session session) throws IOException {
        String sUserId = session.getPathParameters().get("user");

        // Send RefreshUsers Msg to all users
        for (String sUser : oUsers) {
            Session oDestSocket = oSockets.get(sUser);
            if (oDestSocket != null) {
                oDestSocket.getBasicRemote().sendText("{{RefreshUsers}}");
            }
        }

        // Remove Socket from the List
        if (oSockets.containsKey(sUserId)) {
            oSockets.remove(sUserId);
            oUsers.remove(sUserId);
        }
    }

}