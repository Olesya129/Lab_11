import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartPanel;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.Plot;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.plot.XYPlot;
import org.jfree.chart.renderer.xy.XYLineAndShapeRenderer;
import org.jfree.data.xy.XYDataset;
import org.jfree.data.xy.XYSeries;
import org.jfree.data.xy.XYSeriesCollection;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import static java.lang.Math.*;

public class t3 extends JFrame {
    JButton b1;
    JLabel l1, l2;
    JTextField text1, text2;
    JFrame frame = new JFrame("График");
    eWork knopa = new eWork();
    public t3(String s){
        super(s);
        setLayout(new FlowLayout());
        b1 = new JButton("Построить");
        l1 = new JLabel("От");
        l2 = new JLabel("До");
        text1 = new JTextField("", 5);
        text2 = new JTextField("", 5);
        add(l1);
        add(text1);
        add(l2);
        add(text2);
        add(b1);
        b1.addActionListener(knopa);
    }
    public static void main(String[] args) {
        t3 g = new t3("Построение графика");
        g.setVisible(true);
        g.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        g.setSize(300, 180);
        g.setLocationRelativeTo(null);
        g.setResizable(false);
    }
    public double f(double x){
        return 5 * pow(x, 5) - 3 * pow(x, 3) + x * sin(x);
    }
    public class eWork implements ActionListener{
        public void actionPerformed(ActionEvent e) {
            if (e.getSource() == b1) {
                try {
                    double from = Double.parseDouble(text1.getText());
                    double to = Double.parseDouble(text2.getText());
                    if(from >= to){
                        JOptionPane.showMessageDialog(t3.this, "Некорректный диапазон!");
                        return;
                    }
                    XYSeries series = new XYSeries("Функция");
                    double step = abs(to - from)/100;
                    for(double x = from; x <= to; x += step){
                        series.add(x, f(x));
                    }
                    XYDataset xyDataset = new XYSeriesCollection(series);
                    JFreeChart chart = ChartFactory.createXYLineChart("5 * pow(x, 5) - 3 * pow(x, 3) + x * sin(x)", "x",
                            "f(x)", xyDataset, PlotOrientation.VERTICAL,
                            true, true, true);
                    chart.setBackgroundPaint(Color.WHITE);
                    Plot plot = chart.getPlot();
                    plot.setBackgroundPaint(Color.WHITE);
                    ((XYPlot) plot).setRangeGridlinePaint(Color.black);
                    XYLineAndShapeRenderer renderer = (XYLineAndShapeRenderer) ((XYPlot) plot).getRenderer();
                    renderer.setSeriesPaint(0, Color.black);
                    renderer.setSeriesStroke(0, new BasicStroke(2.0f));
                    frame.getContentPane().add(new ChartPanel(chart));
                    frame.setSize(600,600);
                    frame.setVisible(true);
                    JOptionPane.showMessageDialog(t3.this, "График построен!");
                } catch (Exception ex) {
                    JOptionPane.showMessageDialog(t3.this, "Ошибка! " + ex.getMessage());
                }
            }
        }
    }
}
