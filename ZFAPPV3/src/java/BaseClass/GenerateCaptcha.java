package BaseClass;
import java.awt.Color;
import java.awt.Font;
import java.awt.GradientPaint;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.*;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.imageio.ImageIO;
import org.apache.commons.codec.binary.Base64;

public class GenerateCaptcha {

    public GenerateCaptcha() {
    }

    private static final String ALPHA_NUMERIC_STRING =  "123456789ABCDEFGHJKMNPQRSTUVWXYZ";  //"123456789"; //"abcdefghjkmnpqrstuvwxyzABCDEFGHJKMNPQRSTUVWXYZ123456789";
    private static final String NUMERIC_STRING =  "0123456789";

    public static String randomAlphaNumeric(int count) {

        StringBuilder builder = new StringBuilder();

        while (count-- != 0) {

            int character = (int) (Math.random() * ALPHA_NUMERIC_STRING.length());

            builder.append(ALPHA_NUMERIC_STRING.charAt(character));

        }

        return builder.toString();
    }
    
    public  String GenerateCaptchString() {

        StringBuilder builder = new StringBuilder();
        int count = 5 ;
        while (count-- != 0) {

            int character = (int) (Math.random() * ALPHA_NUMERIC_STRING.length());

            builder.append(ALPHA_NUMERIC_STRING.charAt(character));

        }

        return builder.toString();
    }
    
    public  String GenerateActiveCodeString() {

        StringBuilder builder = new StringBuilder();
        int count = 5 ;
        while (count-- != 0) {

            int character = (int) (Math.random() * NUMERIC_STRING.length());

            builder.append(NUMERIC_STRING.charAt(character));

        }

        return builder.toString();
    }

    private static final Random rand = new Random();
    public String GetImage(String Imagedata) {

        try {
            int width = 150;
            int height = 50;

            char data[] = Imagedata.toCharArray();

            BufferedImage bufferedImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);

            Graphics2D g2d = bufferedImage.createGraphics();

            Font font = new Font("Georgia", Font.BOLD, 18);
            g2d.setFont(font);

            RenderingHints rh = new RenderingHints(
                    RenderingHints.KEY_ANTIALIASING,
                    RenderingHints.VALUE_ANTIALIAS_ON);

            rh.put(RenderingHints.KEY_RENDERING,
                    RenderingHints.VALUE_RENDER_QUALITY);

            g2d.setRenderingHints(rh);
            
            float rg = (float) (rand.nextFloat() / 2f + 0.5);
            float gg = (float) (rand.nextFloat() / 2f + 0.5);
            float bg = (float) (rand.nextFloat() / 2f + 0.5);
    
            Color randomColor = new Color(rg, gg, bg);
            

            GradientPaint gp = new GradientPaint(0, 0,
                    Color.white, 0, height / 2, Color.black, true);

            g2d.setPaint(gp);
            g2d.fillRect(0, 0, width, height);

            
            
            float rg1 = (float) (rand.nextFloat() / 2f + 0.5);
            float gg1 = (float) (rand.nextFloat() / 2f + 0.5);
            float bg1 = (float) (rand.nextFloat() / 2f + 0.5);    
            Color randomColorforcolor = new Color(rg1, gg1, bg1);
            
            g2d.setColor(randomColorforcolor.darker());

            Random r = new Random();
            int index = Math.abs(r.nextInt()) % 5;

            

            int x = 0;
            int y = 0;

            for (int i = 0; i < data.length; i++) {
                x += 10 + (Math.abs(r.nextInt()) % 15);
                y = 20 + Math.abs(r.nextInt()) % 25;
                Font rfont = new Font("Georgia", Font.BOLD, getRandomNumberInRange(10,30));
                g2d.setFont(rfont);

            
                  rg1 = (float) (rand.nextFloat() / 2f + 0.5);
                  gg1 = (float) (rand.nextFloat() / 2f + 0.5);
                  bg1 = (float) (rand.nextFloat() / 2f + 0.5);    
                  randomColorforcolor = new Color(rg1, gg1, bg1);
            
                 g2d.setColor(randomColorforcolor.brighter());
                
                g2d.drawChars(data, i, 1, x, y);
                
            }

            g2d.dispose();

            ByteArrayOutputStream os = new ByteArrayOutputStream();
            ImageIO.write(bufferedImage, "png", os);
            os.close();
            byte[] bytedata = os.toByteArray();
            String outencodedfile = new String(Base64.encodeBase64(bytedata), "UTF-8");
            return outencodedfile;

        } catch (IOException ex) {
            Logger.getLogger(GenerateCaptcha.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null;

    }
    
    
        private static  Random rrb = new Random();  
    	private static int getRandomNumberInRange(int min, int max) {

		if (min >= max) {
			return max;
		}	
	     return rrb.nextInt((max - min) + 1) + min;
	}


}
