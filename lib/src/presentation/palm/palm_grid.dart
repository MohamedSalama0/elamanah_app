// lib/src/presentation/farm/widgets/farm_grid_view.dart
import 'package:flutter/material.dart';

class PalmGridView extends StatefulWidget {
  final int rows;
  final int columns;

  const PalmGridView({super.key, required this.rows, required this.columns});

  @override
  _PalmGridViewState createState() => _PalmGridViewState();
}

class _PalmGridViewState extends State<PalmGridView> {
  final TransformationController _transformationController =
      TransformationController();
  double _scale = 1.0;
  List<List<PalmStatus>> _gridData = [];

  @override
  void initState() {
    super.initState();
    // Initialize grid with all palms in normal state
    _gridData = List.generate(
      widget.rows,
      (_) => List.filled(widget.columns, PalmStatus.normal),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Zoom controls
        _buildZoomControls(),
        Expanded(
          child: InteractiveViewer(
            transformationController: _transformationController,
            minScale: 0.1,
            maxScale: 4.0,
            onInteractionUpdate: (ScaleUpdateDetails details) {
              setState(() {
                _scale = details.scale;
              });
            },
            child: Container(
              color: Colors.green[50],
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: widget.columns,
                  childAspectRatio: 1.0,
                ),
                itemCount: widget.rows * widget.columns,
                itemBuilder: (context, index) {
                  final row = index ~/ widget.columns;
                  final col = index % widget.columns;
                  return _buildPalmCard(row, col, _gridData[row][col]);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPalmCard(int row, int col, PalmStatus status) {
    final colors = {
      PalmStatus.normal: Colors.green,
      PalmStatus.needsWater: Colors.blue,
      PalmStatus.needsFertilizer: Colors.orange,
      PalmStatus.hasIssue: Colors.red,
      PalmStatus.harvested: Colors.brown,
    };

    return GestureDetector(
      onTap: () => _showPalmDetails(row, col),
      child: Container(
        margin: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: colors[status],
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 2,
              offset: Offset(1, 1),
            ),
          ],
        ),
        child: Center(
          child:
              _scale > 0.5
                  ? FittedBox(
                    child: Text(
                      '${row + 1}x${col + 1}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: _scale > 1.5 ? 12 : 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                  : null,
        ),
      ),
    );
  }
  bool _canZoomOut(){
    if( _scale * 100 <30) return false; 

    return true;
  }
  bool _canZoomIn(){
    if(_scale * 100 > 800 ) return false; 

    return true;
  }
  
  Widget _buildZoomControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.zoom_out),
            onPressed: !_canZoomOut()?null:() {
              _transformationController.value =
                  Matrix4.identity()..scale(_scale * 0.8);
              setState(() {
                _scale *= 0.8;
              });
            },
          ),
          Text('${(_scale * 100).toStringAsFixed(0)}%'),
          IconButton(
            icon: Icon(Icons.zoom_in),
            onPressed:!_canZoomIn()?null: () {
              _transformationController.value =
                  Matrix4.identity()..scale(_scale * 1.2);
              setState(() {
                _scale *= 1.2;
              });
            },
          ),
        ],
      ),
    );
  }

  void _showPalmDetails(int row, int col) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Palm ${row + 1}x${col + 1}'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Status: ${_gridData[row][col].toString().split('.').last}',
                ),
                SizedBox(height: 16),
                DropdownButton<PalmStatus>(
                  value: _gridData[row][col],
                  items:
                      PalmStatus.values.map((status) {
                        return DropdownMenuItem<PalmStatus>(
                          value: status,
                          child: Text(status.toString().split('.').last),
                        );
                      }).toList(),
                  onChanged: (newStatus) {
                    if (newStatus != null) {
                      setState(() {
                        _gridData[row][col] = newStatus;
                      });
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Close'),
              ),
            ],
          ),
    );
  }
}

enum PalmStatus { normal, needsWater, needsFertilizer, hasIssue, harvested }
